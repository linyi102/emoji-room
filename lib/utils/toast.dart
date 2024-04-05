import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static showText(String msg) {
    if (msg.isEmpty) return;

    BotToast.showCustomText(
      align: const Alignment(0, 0.8),
      onlyOne: true,
      toastBuilder: (cancelFunc) {
        const bg = Colors.black;
        const fg = Colors.white;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Card(
            color: bg,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.6),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                msg,
                style: const TextStyle(color: fg, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
