import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // ルーティング
import 'package:intl/intl.dart'; // ロケール。日時表示で使う。
import '../database.dart'; // DB
import '../snackbars.dart'; // スナックバー
import '../dialogs/delete_dialog.dart'; // 削除確認ダイアログ
import '../validators.dart'; // バリデート
import '../common.dart'; // Databaseオブジェクト
import 'package:flutter/services.dart'; 


class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    final list = Expanded(
      child: StreamBuilder(
        stream: db.watchEntries(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // snapshot.data![i].カラム名 では長いので
          List<Todo>  tl = snapshot.data ?? [];
          
          // return ListView.builder(        
          return ReorderableListView.builder( // ListView → ReorderableListView
            onReorder: (int oldIndex, int newIndex) async{                        
              if (oldIndex < newIndex) {
                // 降順表示で下方向に動かした場合
                await db.updateChangeIndex(tl[oldIndex].id, tl[oldIndex].index, tl[newIndex - 1].id, tl[newIndex - 1].index);   
              }else{
                // 降順表示で上方向に動かした場合
                await db.updateChangeIndex(tl[oldIndex].id, tl[oldIndex].index, tl[newIndex].id, tl[newIndex].index);   
              }          
              
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                Todo item =  tl.removeAt(oldIndex);
                tl.insert(newIndex, item);                                               
              });
            },     
            itemCount: tl.length,
            itemBuilder: (context, i) => ListTile(
              key: Key((tl[i].id).toString()), // 1
              leading: const Icon(Icons.person),
              title: Text(tl[i].content),
              subtitle: Text( 
                "[ID:${tl[i].id}] ${DateFormat('yyyy-MM-dd HH:mm:ss').format(tl[i].createDatetime)}" 
              ),
              trailing:  Wrap(
                spacing: 5, // アイコンの間の幅を調整
                children: [              
                  IconButton( // 2
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      context.push('/edit/${tl[i].id}');
                    },
                  ), 
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async { // 3
                      final res = await showDialog(
                        context: context,
                        builder: (_) => const DeleteDialog(),
                      );
                      if(res != null && res == 'delete_ok'){ // 4
                        await db.deleteTodo(tl[i].id); // 5
                        if (context.mounted) { // 6
                          ScaffoldMessenger.of(context).showSnackBar(
                            deletedSnackBar(tl[i].id)
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    final controller = TextEditingController(); // 7

    final addTextField = TextFormField( 
      autofocus: true, // 自動フォーカス
      controller: controller,
      validator: (value) { return validateContent(value); },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "内容",
        hintText: "100文字以内で入力してください",
        errorText: null, // エラーメッセージ用（今回使わない）
      ),
    );

    Future<KeyEventResult> manageKeyboard(KeyEvent event) async { // 1
      final key = event.logicalKey; // 2
      if (event is KeyDownEvent) {
        if ( key == LogicalKeyboardKey.enter ) { // 3
        final mytext = controller.text;
        final res = validateContent(mytext);
          if (res == '') {  // バリデーター通過時のみ実行
            final insId = await db.insertTodo(mytext, DateTime.now());
            await db.updateIndex_id1(insId);
            
            if (context.mounted) { 
              ScaffoldMessenger.of(context).showSnackBar(
                createdSnackBar("[ID:$insId]$mytext"),
              );
            }
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              errorSnackBar(res),
            );
          }
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    }

    // 入力欄で「Enterキー投稿」の機能
    final addTextFieldFocus = Focus( // 1
      // autofocus: true にはしない(Focus側) // 2
      onKeyEvent: (node, event) { // 3
        manageKeyboard(event);
        return KeyEventResult.ignored;
      },
      child: addTextField, // 4
    );

    final body = SafeArea( // ボディー
      child: Column(
        children: [
          Expanded( 
           child: list,
          ),
          // addTextField, 
          addTextFieldFocus, // addTextField → addTextFieldFocus
          const SizedBox( height: 20, ), // 隙間を空ける
        ],
      )
    );

    final fab = FloatingActionButton( // 10
      onPressed: () async {
        final mytext = controller.text;
        final res = validateContent(mytext);
        if (res == '') {  // バリデーター通過時のみ実行
          final insId = await db.insertTodo(mytext, DateTime.now());
          await db.updateIndex_id1(insId);
          controller.clear(); // 入力欄をクリア
          if (context.mounted) { 
            ScaffoldMessenger.of(context).showSnackBar(
              createdSnackBar("[ID:$insId]$mytext"),
            );
          }
        }else{ 
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(res),
          );
        }
      },
      tooltip: '入力されたものを追加',
      backgroundColor: const Color.fromARGB(255, 225, 240, 139),
      child: const Icon(Icons.add),
    );

    return Scaffold(
      body: body, // ボディー
      floatingActionButton: fab, // フローティングアクションボタン
    );
  }
}
