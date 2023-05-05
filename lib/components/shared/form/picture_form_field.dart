import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:repege/components/shared/circle_icon.dart';

class PictureFormField extends StatefulWidget {
  const PictureFormField({
    this.label,
    this.width = 175,
    this.height = 175,
    this.initialValue,
    this.onChange,
    super.key,
  });

  final String? label;
  final String? initialValue;
  final double width;
  final double height;
  final void Function(File?)? onChange;

  @override
  State<PictureFormField> createState() => _PictureFormFieldState();
}

class _PictureFormFieldState extends State<PictureFormField> {
  Uint8List? imageBytes;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: '',
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null) return;

    final imagePath = result.files.first.path;

    if (imagePath == null) return;

    final imageFile = File(imagePath);

    setState(() => imageBytes = imageFile.readAsBytesSync());

    if (widget.onChange != null) widget.onChange!(imageFile);
  }

  ImageProvider get image {
    if (imageBytes != null) {
      return MemoryImage(imageBytes!);
    }
    if (widget.initialValue != null) {
      return NetworkImage(widget.initialValue!);
    }
    return const AssetImage("assets/images/default_profile_picture.png");
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          if (widget.label != null) Text(widget.label!),
          InkWell(
            borderRadius: BorderRadius.circular(200),
            onTap: pickImage,
            child: Ink(
              width: widget.width,
              height: widget.height,
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.5),
                backgroundImage: image,
                child: CircleIcon(
                  icon: Icon(
                    Icons.camera_alt,
                    color: colors.primary,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
