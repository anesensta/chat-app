import 'package:chatapp/compennet/button.dart';
import 'package:chatapp/compennet/textfield.dart';
import 'package:chatapp/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/servises/auth.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email1 = TextEditingController();
  TextEditingController password10 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.message,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'welcom back, you\'v been missed ',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 20,
          ),
          MYTEXTFORM(
              controller1: email1, hinttext: 'Email', obscuretext: false),
          MYTEXTFORM(
              controller1: password10, hinttext: 'password', obscuretext: true),
          Button(
            text: 'Login',
            ontap: () {
              Auth().singin(email1.text, password10.text, context);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?  ',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Register(),
                  ));
                },
                child: Text(
                  'Register now',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
