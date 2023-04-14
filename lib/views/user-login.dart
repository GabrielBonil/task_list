import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class UserLoginPage extends StatefulWidget {
  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  var mostrarSenha = false;

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'O campo deve ter pelo menos 6 caracteres.';
    }
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode estar vazio';
    }

    if (!EmailValidator.validate(value)) {
      return 'Digite um E-mail valido!';
    }

    return null;
  }

  var formKey = GlobalKey<FormState>();

  void salvar(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.of(context).popAndPushNamed('/task-list'); //Talvez tenha que mudar o tipo de troca depois
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            //E-mail
            TextFormField(
              maxLength: 50,
              decoration: InputDecoration(
                // icon: Icon(Icons.people_alt_rounded),
                hintText: "E-mail",
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black),),
              ),
              onSaved: (newValue) {},
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validarEmail,
            ),

            //Senha
            TextFormField(
              obscureText: !mostrarSenha,
              maxLength: 50,
              decoration: InputDecoration(
                // icon: Icon(Icons.lock),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black),),
                hintText: "Senha",
                suffixIcon: IconButton(
                  icon: Icon(mostrarSenha ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                ),
              ),
              validator: validarSenha,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
            ),

            //Botão Logar
            Container(
              width: MediaQuery.of(context).size.width -
                  40, //width: double.infinity,
              child: ElevatedButton(
                onPressed: () => salvar(context),
                child: Text("Logar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
