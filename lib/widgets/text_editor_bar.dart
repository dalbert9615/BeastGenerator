import 'package:flutter/material.dart';

class TextEditorBar extends StatefulWidget {
  const TextEditorBar({
    required this.onNewMessage,
    Key? key,
  }) : super(key: key);
  final void Function(String) onNewMessage;

  @override
  State<TextEditorBar> createState() => _TextEditorBarState();
}

class _TextEditorBarState extends State<TextEditorBar> {
  Color c = const Color.fromARGB(255, 144, 94, 143);
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 40,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 144, 94, 143),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              onSubmitted: (text) {
                //para usar enter
                widget.onNewMessage(text);
                controller.clear();
                //Navigator.pushNamed(context, '/Details');
              },
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a Beast!',
                hintStyle: TextStyle(color: Colors.white60)
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: (() {
              widget.onNewMessage(controller.text);
              controller.clear();
            }),
          )
        ],
      ),
    );
  }
}
