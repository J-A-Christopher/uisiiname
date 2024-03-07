import 'package:flutter/material.dart';

class ChatInputBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend, onClickCamera;

  const ChatInputBox({
    super.key,
    this.controller,
    this.onSend,
    this.onClickCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (onClickCamera != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                  onPressed: onClickCamera,
                  icon: const Icon(Icons.file_copy_rounded)),
            ),
          Expanded(
              child: TextField(
            controller: controller,
            minLines: 1,
            maxLines: 6,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              hintText: 'Message',
              border: InputBorder.none,
            ),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          )),
          Padding(
            padding:
                const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 2),
            child: FloatingActionButton.small(
              onPressed: onSend,
              child: const Icon(Icons.send_rounded),
            ),
          )
        ],
      ),
    );
  }
}
