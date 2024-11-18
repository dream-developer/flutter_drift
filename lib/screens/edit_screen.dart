import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../snackbars.dart';
import '../validators.dart';
import '../database.dart';
import '../common.dart'; // Databaseオブジェクト

class EditScreen extends StatelessWidget {
  const EditScreen({ 
    super.key,
    required this.id, // 1
  });

  final int id; // 1
  
  @override
  Widget build(BuildContext context) {
    const formKey = GlobalObjectKey<FormState>('FORM_KEY');

    final appBar = AppBar(
      title: Text('編集画面[id:$id]'),
    );

    final controller = TextEditingController();
    final ftTodo =  db.getTodo(id); // 2

    final textField = FutureBuilder( // 3
      future: ftTodo,
      builder: (BuildContext context, AsyncSnapshot<Todo> snapshot) {
        if (snapshot.hasData) {
          final dataValue = snapshot.data?.content;
          if (dataValue != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) { // 4
              controller.text = dataValue;
            });
          }else{
            controller.text = 'nullですよ';
          }              
          return TextFormField(
            controller: controller,
              validator: (value) {
                final res = validateContent(value);
                return res != '' ? res : null ;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "内容",
                hintText: "100文字以内で入力してください",
                errorText: null, // エラーメッセージ用（今回使わない）
              ),
          );
        } else {   
          return TextFormField(
            controller: controller,
          );
        }
      },
    );

    final updButton = ElevatedButton( // 5
      onPressed: () async {
        final mytext = controller.text;
        if (formKey.currentState!.validate()) {  // バリデーター通過時のみ実行
          await db.updateTodo(id, mytext);
          if(context.mounted){ 
            ScaffoldMessenger.of(context).showSnackBar(
              updatedSnackBar(id),
            );
            context.go('/list'); // 6
          }
        } 
      },
      child: const Text("更新する"),
    );
    
    final goListButton = ElevatedButton( // 7
      onPressed: () => {
        context.go('/list')
      },
      child: const Text("一覧に戻る"),
    );

    return Scaffold(
      appBar: appBar,
      body: Form( 
        key: formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            textField,
            updButton,
            goListButton,
          ],
        ),
      ),
    );
  }
}