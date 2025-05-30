import 'package:chatapp/compennet/drawer.dart';
import 'package:chatapp/compennet/listtileuser.dart';

import 'package:chatapp/servises/firestore.dart';
import 'package:chatapp/thems/themprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestoreuse().useresexpetblock(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              drawer: MYDrawer(),
              appBar: AppBar(
                  title: Text('Home '),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: Provider.of<Themprovider>(context).isdarkmode
                      ? Colors.white
                      : Colors.black),
              body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return mylisttile(
                    reciveruid: snapshot.data![index]['id'],
                    email: snapshot.data![index]['email'],
                    i: index,
                    info: snapshot.data!,
                  );
                },
              ));
        });
  }
}
