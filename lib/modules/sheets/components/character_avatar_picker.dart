import 'dart:io';

import 'package:flutter/material.dart';

class CharacterAvatarPicker extends StatefulWidget {
  const CharacterAvatarPicker({super.key});

  @override
  State<CharacterAvatarPicker> createState() => _CharacterAvatarPickerState();
}

class _CharacterAvatarPickerState extends State<CharacterAvatarPicker> {
  File? pickedAvatar;

  void handlePicker() {}

  Image get pickedImage {
    if (pickedAvatar != null) {
      return Image.file(
        pickedAvatar!,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      'assets/images/default_avatar.jpg',
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          pickedImage,
          Positioned(
            width: 40,
            height: 40,
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                print('hey');
              },
              color: Colors.white,
              icon: const Icon(
                Icons.camera_alt,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
