import 'package:flutter/widgets.dart';

bool isSnapshotLoading<T>(AsyncSnapshot<T> snapshot) {
  return snapshot.connectionState == ConnectionState.waiting;
}
