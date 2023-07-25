import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(
    this.label, {
    this.onImagePicked,
    this.source = ImageSource.gallery,
    super.key,
    this.height,
    this.padding,
    this.width,
  });

  final String label;
  final double? height;
  final EdgeInsets? padding;
  final double? width;
  final void Function(File?)? onImagePicked;
  final ImageSource source;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final imagePicker = ImagePicker();
  File? pickedImage;

  Future<void> _pickImage() async {
    final image = await imagePicker.pickImage(
      source: widget.source,
      maxHeight: 240,
    );

    if (image == null) return;

    final bytes = await image.readAsBytes();
    final imageFile = File.fromRawPath(bytes);

    setState(() {
      pickedImage = imageFile;
    });

    if (widget.onImagePicked != null) widget.onImagePicked!(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: _pickImage,
      child: Ink(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade600,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
