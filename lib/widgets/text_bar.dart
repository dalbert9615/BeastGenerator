import 'package:flutter/material.dart';

class TextBar extends StatelessWidget {
  const TextBar({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 60,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 46, 46, 46),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
       
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                text,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
