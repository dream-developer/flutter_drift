import 'package:flutter/material.dart';
import './database.dart'; // 1
import 'package:intl/intl.dart'; // ロケール。日時表示で使う。

final db = Database();

void main() {
  final list = Expanded(
    child: StreamBuilder( // 2
      stream: db.watchEntries(), // 3
      builder: // 4
          (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) { // 5
          return const Center(child: CircularProgressIndicator());
        }

        // snapshot.data![i].カラム名 では長いので
        List<Todo>  tl = snapshot.data ?? []; // 6
        
        return ListView.builder( // 7       
          itemCount: snapshot.data!.length,
          itemBuilder: (context, i) => ListTile(
            leading: const Icon(Icons.person),
            title: Text(tl[i].content), // 8
            subtitle: Text(  // 9
              "[ID:${tl[i].id}] ${DateFormat('yyyy-MM-dd HH:mm:ss').format(tl[i].createDatetime)}" 
            ),
            trailing:  Wrap(
              spacing: 5, // アイコンの間の幅を調整
              children: [
                IconButton( // 10
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await db.updateTodo(tl[i].id, '更新');
                  },
                ), 
                IconButton( // 11
                  icon: const Icon(Icons.delete),
                  onPressed: () async { 
                    await db.deleteTodo(tl[i].id);
                  },
                ),
              ],
            ),
            tileColor: Colors.purple[50], // アイテムの背景色
          ),
        );
      },
    ),
  );

  final addButton = ElevatedButton( // 12
    child: const Text('追加'),
    onPressed: () async {
      final insId = await db.insertTodo("追加", DateTime.now()); // 13
      await db.updateIndex_id1(insId); // 14
    },
  );

  final body = SafeArea( // ボディー
    child: Column(
      children: [
        list,
        addButton,
      ],
    )
  );

  final sc = Scaffold(
    body: body, // ボディー
  );

  final app = MaterialApp(home: sc);
  runApp(app);
}