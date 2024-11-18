import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
            Icon(Icons.delete, color: Colors.red,)
          ,Text('削除確認'),
        ]),
      content: const Text('本当に削除しても良いですか？'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('キャンセル',
            style: TextStyle(
             color: Colors.black87)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'delete_ok');
          },
          child: const Text(
            '削除',
            style: TextStyle(
             color: Colors.red),
           ),
        ),
      ],
    );
  }
}