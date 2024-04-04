import 'dart:async';

extension Delay on num {
  Future delay([FutureOr Function()? computation]) {
    return Future.delayed(Duration(milliseconds: round()), computation);
  }

  num get second => this * 1000;
}
