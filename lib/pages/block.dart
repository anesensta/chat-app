import 'package:chatapp/servises/firestore.dart';
import 'package:chatapp/thems/themprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Block extends StatelessWidget {
  const Block({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Provider.of<Themprovider>(context).isdarkmode
              ? Colors.white
              : Colors.black,
          title: Text('Block list'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: firestoreuse().blocklist(userid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                'No block useres availble',
                style: TextStyle(
                    color: Provider.of<Themprovider>(context, listen: false)
                            .isdarkmode
                        ? Colors.white
                        : Colors.black),
              ));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Theme.of(context).colorScheme.secondary,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'unblock user',
                                      style: TextStyle(
                                          color: Provider.of<Themprovider>(
                                                      context,
                                                      listen: false)
                                                  .isdarkmode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    content: Text(
                                      'are you sure want to unblock this user?',
                                      style: TextStyle(
                                          color: Provider.of<Themprovider>(
                                                      context,
                                                      listen: false)
                                                  .isdarkmode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'cancel',
                                            style: TextStyle(
                                                color:
                                                    Provider.of<Themprovider>(
                                                                context,
                                                                listen: false)
                                                            .isdarkmode
                                                        ? Colors.white
                                                        : Colors.black),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            firestoreuse().unblockuser(snapshot
                                                .data![index]['userid']);
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              'this user has been unblock',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )));
                                          },
                                          child: Text(
                                            'unblock',
                                            style: TextStyle(
                                                color:
                                                    Provider.of<Themprovider>(
                                                                context,
                                                                listen: false)
                                                            .isdarkmode
                                                        ? Colors.white
                                                        : Colors.black),
                                          ))
                                    ],
                                  );
                                });
                          },
                          title: Text('${snapshot.data![index]['email']}'),
                          leading: Icon(Icons.person),
                        ),
                      ),
                    ));
              },
            );
          },
        ));
  }
}
