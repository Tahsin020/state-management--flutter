import 'package:flutter/cupertino.dart';

enum ImageEnums { door }

extension ImageEnumsExtension on ImageEnums {
  String get _toPath => 'assets/images/ic_$name.png';
  Image get toImage => Image.asset(_toPath);
}
