import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    required this.builder,
    this.onImagePicked,
    this.source = ImageSource.gallery,
    required this.initialImage,
    super.key,
    this.alignment = Alignment.center,
    this.boxfit,
    this.height,
    this.padding,
    this.width,
    this.rect = const Rect.fromLTRB(0, 0, 0, 0),
  });

  final Rect rect;
  final ImageProvider initialImage;
  final Alignment alignment;
  final BoxFit? boxfit;
  final double? height;
  final EdgeInsets? padding;
  final double? width;
  final void Function(File?)? onImagePicked;
  final ImageSource source;
  final Widget Function(BuildContext context, File? image) builder;

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

  ImageProvider get image {
    return pickedImage != null ? FileImage(pickedImage!) : widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      child: Ink.image(
        image: image,
        alignment: widget.alignment,
        fit: widget.boxfit,
        height: widget.height,
        padding: widget.padding,
        width: widget.width,
        child: Stack(
          children: [
            widget.builder(context, pickedImage),
            Positioned.fromRect(
              rect: widget.rect,
              child: const Icon(Icons.camera_alt, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
