import 'package:flutter/material.dart';

class RouteUtil {
  static Future<T?> materialTo<T extends Object?>(
      BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }
}
