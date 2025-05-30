import "dart:async";

import "package:chatapp/pages/homepage.dart";
import "package:chatapp/pages/login.dart";
import "package:chatapp/thems/themprovider.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

class Auth {
  bool wait = false;
  //instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _firestore1 = FirebaseFirestore.instance.collection('useres');
  //get user
  User getuser() {
    return auth.currentUser!;
  }

  //singnin
  Future singin(
      String emailAdderessi, String passwordi, BuildContext contex) async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAdderessi, password: passwordi);
      _firestore1.doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'email': credential.user!.email,
      });
      Navigator.of(contex).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: contex,
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
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                  content: Text(
                    'No user found for that email.',
                    style: TextStyle(
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                ));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: contex,
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
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                  content: Text(
                    'Wrong password provided for that user.',
                    style: TextStyle(
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                ));
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print('===========================eror=$e');
    }
  }

  //singup
  Future register(
      String emailAdderess, String password, BuildContext contex) async {
    try {
      // ignore: unused_local_variable
      final credantiol =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAdderess,
        password: password,
      );
      _firestore1
          .doc(credantiol.user!.uid)
          .set({'id': credantiol.user!.uid, 'email': credantiol.user!.email});

      Navigator.of(contex).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ),
        (route) {
          return false;
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context: contex,
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
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                  content: Text(
                    'Entre a strong password.',
                    style: TextStyle(
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                ));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: contex,
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
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                  content: Text(
                    'The account already exists for that email.',
                    style: TextStyle(
                        color: Provider.of<Themprovider>(context, listen: false)
                                .isdarkmode
                            ? Colors.white
                            : Colors.black),
                  ),
                ));
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //singout
  Future singout(contex) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(contex).pushAndRemoveUntil(
        MaterialPageRoute(builder: (contex) => Login()), (Route) => false);
  }
  //eror
}
