import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class imageZoom extends StatelessWidget {
  final String linkIMAGE;

  const imageZoom({
    Key? key,
    required this.linkIMAGE,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      offset: const Offset(-1.0, 1.0),
      child: PinchZoom(
        resetDuration: const Duration(milliseconds: 300),
        maxScale: 7.0,
        child: Image.network("/assets/png/ejemplo.png"),
      ),
    );
  }
}
