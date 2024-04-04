import 'package:flutter/material.dart';

class GapW extends StatelessWidget {
  const GapW(this.size, {super.key});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}

class GapH extends StatelessWidget {
  const GapH(this.size, {super.key});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
