import 'package:flutter/material.dart';

createdSnackBar(String msg){ // msg を受け取る
  final sbMsg = msg.length >= 20 ? msg.substring(0, 20) + ' ……' : msg;
  return SnackBar(
  content: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('【追加しました】'),
      Text(sbMsg),
      ],
    ),
  );
}

deletedSnackBar(int id){
  return SnackBar(
    backgroundColor: Colors.red,
    content: Text('ID:[$id]のデータを削除しました'),
  );
}

updatedSnackBar(int id){ // id を受け取る
  return SnackBar(
    backgroundColor: const Color.fromARGB(255, 79, 54, 244),
    content: Text('ID:[$id]のデータを更新しました'),
  );
}

errorSnackBar(String msg){ // msg を受け取る
  return SnackBar(
    backgroundColor: Colors.red,
    content: Text(msg),
    );
}