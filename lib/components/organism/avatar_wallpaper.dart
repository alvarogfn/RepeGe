import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWallpaper extends StatelessWidget {
  AvatarWallpaper({
    required this.image,
    super.key,
    this.onChanged,
  });

  final imagePicker = ImagePicker();

  final ImageProvider image;

  final void Function(File? file)? onChanged;

  Future<void> pickImage(BuildContext context) async {
    try {
      final xfile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 240,
      );

      if (xfile == null) return;

      final bytes = await xfile.readAsBytes();

      final file = File.fromRawPath(bytes);

      if (onChanged != null) onChanged!(file);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImage(context),
      child: Ink(
        height: 240,
        width: double.infinity,
        decoration: decoration(),
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          child: positionedCamera(),
        ),
      ),
    );
  }

  Stack positionedCamera() {
    return Stack(
      children: const [
        Positioned(
          top: 10,
          left: 10,
          child: Icon(Icons.camera_alt, color: Colors.white),
        )
      ],
    );
  }

  BoxDecoration decoration() {
    return const BoxDecoration(boxShadow: [
      BoxShadow(
        offset: Offset(0, 1),
        color: Colors.black54,
        blurRadius: 2,
      ),
    ], border: Border(bottom: BorderSide(color: Colors.black, width: 2)));
  }
}
