import 'package:chatapp/pages/chat.dart';
import 'package:flutter/material.dart';

class mylisttile extends StatelessWidget {
  final String reciveruid;
  final String email;
  final List info;

  final int i;
  mylisttile({
    super.key,
    required this.info,
    required this.i,
    required this.email,
    required this.reciveruid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Theme.of(context).colorScheme.secondary,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Chat(
                      emailuser: email,
                      reciveruid: reciveruid,
                    )));
          },
          title: Text('${info[i]['email']}'),
          leading: Icon(Icons.person),
        ),
      ),
    );
  }
}
