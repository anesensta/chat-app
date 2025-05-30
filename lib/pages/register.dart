import 'package:chatapp/servises/auth.dart';
import 'package:chatapp/compennet/button.dart';
import 'package:chatapp/compennet/textfield.dart';
import 'package:chatapp/pages/login.dart';
import 'package:chatapp/thems/themprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailr = TextEditingController();
  TextEditingController passwordr = TextEditingController();
  TextEditingController confirmpasswordr = TextEditingController();
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
            'Let\'s creat an account for you ',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 20,
          ),
          MYTEXTFORM(
              controller1: emailr, hinttext: 'Email', obscuretext: false),
          MYTEXTFORM(
              controller1: passwordr, hinttext: 'password', obscuretext: true),
          MYTEXTFORM(
              controller1: confirmpasswordr,
              hinttext: 'confirm password',
              obscuretext: true),
          Button(
            text: 'Register',
            ontap: () {
              if (confirmpasswordr.text == passwordr.text) {
                Auth().register(emailr.text, passwordr.text, context);
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'close',
                                  style: TextStyle(
                                      color: Provider.of<Themprovider>(context,
                                                  listen: false)
                                              .isdarkmode
                                          ? Colors.white
                                          : Colors.black),
                                ))
                          ],
                          title: Text(
                            'Eror',
                            style: TextStyle(
                                color: Provider.of<Themprovider>(context,
                                            listen: false)
                                        .isdarkmode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          content: Text(
                            'The two password does not math.',
                            style: TextStyle(
                                color: Provider.of<Themprovider>(context,
                                            listen: false)
                                        .isdarkmode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ));
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?  ',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) {
                      return false;
                    },
                  );
                },
                child: Text(
                  'login now',
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
