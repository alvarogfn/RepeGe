import 'dart:io';
import 'package:flutter/material.dart';

class ProfileFormModel {
  late final TextEditingController username;
  late final TextEditingController email;
  File? profilePicture;

  ProfileFormModel({
    String email = '',
    String username = '',
  }) {
    this.username = TextEditingController(text: username);
    this.email = TextEditingController(text: email);
  }
}
