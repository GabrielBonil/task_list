import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  void salvar(BuildContext context) {
    if (formKey.currentState!.validate()) {

      formKey.currentState!.save();

      //salvar os dados no banco de dados...
      // firestore.add({'name':'task...'});

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              minLines: 1,
              maxLines: 5,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: "O que precisa fazer?",
              ),
              onSaved: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo obrigatório. >:(";
                }
                return null;
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width -
                  40, //width: double.infinity,
              child: ElevatedButton(
                onPressed: () => salvar(context),
                child: Text("Salvar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
