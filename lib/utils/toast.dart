import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static Future<T?> showDialog<T>({
    required Widget Function(void Function({T? result}) close) builder,
    bool clickClose = true,
  }) async {
    T? dialogResult;
    Completer<T?> completer = Completer();
    BotToast.showCustomLoading(
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      clickClose: clickClose,
      onClose: () {
        completer.complete(dialogResult);
      },
      toastBuilder: (cancelFunc) {
        return WillPopScope(
          child: builder(({result}) {
            dialogResult = result;
            cancelFunc();
          }),
          onWillPop: () async {
            // 如果允许点击对话框外区域，或点击虚拟返回键关闭对话框，则执行关闭
            if (clickClose) cancelFunc();
            // 始终返回false，避免退出页面
            return false;
          },
        );
      },
    );
    return completer.future;
  }

  static showText(String msg) {
    if (msg.isEmpty) return;

    BotToast.showCustomText(
      align: const Alignment(0, -0.8),
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
