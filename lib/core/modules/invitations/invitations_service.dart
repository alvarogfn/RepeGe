import 'package:flutter/material.dart';
import 'package:repege/modules/auth/services/auth_service.dart';

class InvitationsService extends ChangeNotifier {
  AuthService authService;

  InvitationsService(this.authService);

  Stream<List<dynamic>> streamAll() async* {}
}
