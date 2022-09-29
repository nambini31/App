// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/Ecran/second_page.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String nom = "";
  String mot_de_passe = "";
  String text = "";
  // void submit(String e) {
  //   setState(() {
  //     text = "Message envoyé a $e";
  //   });
  // }

  var formValide = GlobalKey<FormState>();

  void login(String nom, String mot_de_passe) async {
    final response = await http.post(Uri.parse('http://192.168.74.1/app/lib/php/login.php'), body: {"username": nom, "password": mot_de_passe});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data[0] == 0) {
        print("tsy mitovy");
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return Secondpage();
        }));
      }
    } else {
      print("rien");
    }
  }

  void change(String e) {
    setState(() {
      text = e;
    });
  }

  void validationform() {
    if (formValide.currentState!.validate()) {
      login(nom, mot_de_passe);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formValide,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Nom",
                    hintText: "Entrer votre nom",
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      nom = value;
                    });
                  },
                  validator: (value) => value!.isEmpty ? "Veuillez entrer votre nom" : null,
                  onSaved: (newValue) {
                    nom = newValue!;
                  },
                  //onSubmitted: submit,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      mot_de_passe = value;
                    });
                  },
                  validator: (value) => value!.isEmpty ? "Veuillez entrer votre mot de passe" : null,
                  onSaved: (newValue) {
                    mot_de_passe = newValue!;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "mot de passe",
                    hintText: "Entrer votre mot de passe",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: validationform,
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.pink)),
                  child: Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
