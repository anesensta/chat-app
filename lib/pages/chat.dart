import 'package:chatapp/compennet/textfield.dart';
import 'package:chatapp/servises/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:provider/provider.dart';

import '../thems/themprovider.dart';

class Chat extends StatefulWidget {
  final String reciveruid;
  final String emailuser;

  Chat({
    super.key,
    required this.emailuser,
    required this.reciveruid,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController mesagecon = TextEditingController();
  FocusNode focusnode = FocusNode();
  ScrollController scroll = ScrollController();
  void scrolltobuttom() {
    scroll.animateTo(scroll.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    focusnode.addListener(
      () {
        if (focusnode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 1000),
            () {
              scrolltobuttom();
            },
          );
        }
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        scrolltobuttom();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    mesagecon.dispose();
    focusnode.dispose();
    scroll.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final senderuid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Provider.of<Themprovider>(context).isdarkmode
                ? Colors.white
                : Colors.black,
            title: Text(widget.emailuser),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        value: 'a',
                        child: Row(
                          children: [
                            Icon(Icons.block),
                            Text(
                              '  Block',
                              style: TextStyle(
                                  color: Provider.of<Themprovider>(context,
                                              listen: false)
                                          .isdarkmode
                                      ? Colors.white
                                      : Colors.black),
                            )
                          ],
                        ))
                  ];
                },
                onSelected: (value) {
                  if (value == 'a') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Block user',
                          style: TextStyle(
                              color: Provider.of<Themprovider>(context,
                                          listen: false)
                                      .isdarkmode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        content: Text(
                          'are you sure that you want to block this user?',
                          style: TextStyle(
                              color: Provider.of<Themprovider>(context,
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
                                    color: Provider.of<Themprovider>(context,
                                                listen: false)
                                            .isdarkmode
                                        ? Colors.white
                                        : Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                firestoreuse().blockuser(widget.reciveruid);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  'this user has been blocked',
                                  style: TextStyle(
                                      color: Provider.of<Themprovider>(context,
                                                  listen: false)
                                              .isdarkmode
                                          ? Colors.white
                                          : Colors.black),
                                )));
                              },
                              child: Text(
                                'block',
                                style: TextStyle(
                                    color: Provider.of<Themprovider>(context,
                                                listen: false)
                                            .isdarkmode
                                        ? Colors.white
                                        : Colors.black),
                              ))
                        ],
                      ),
                    );
                  }
                },
              )
            ]),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firestoreuse().getmessage(widget.reciveruid, senderuid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('eror');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                      'No messages yet',
                      style: TextStyle(
                          color:
                              Provider.of<Themprovider>(context, listen: false)
                                      .isdarkmode
                                  ? Colors.white
                                  : Colors.black),
                    ));
                  }

                  return ListView.builder(
                    controller: scroll,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment:
                            snapshot.data![index]['senderid'] == senderuid
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onLongPress: () {
                              if (snapshot.data![index]['senderid'] !=
                                  senderuid) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'report message',
                                            style: TextStyle(
                                                color:
                                                    Provider.of<Themprovider>(
                                                                context,
                                                                listen: false)
                                                            .isdarkmode
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),
                                          leading: Icon(
                                            Icons.flag,
                                            color: Provider.of<Themprovider>(
                                                        context,
                                                        listen: false)
                                                    .isdarkmode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(
                                                    'are you sure that you want to report this message?',
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        Themprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isdarkmode
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  title: Text(
                                                    'Report user',
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        Themprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isdarkmode
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color: Provider.of<
                                                                              Themprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isdarkmode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          firestoreuse().reportmessage(
                                                              snapshot.data![
                                                                      index]
                                                                  ['messageid'],
                                                              widget
                                                                  .reciveruid);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Text(
                                                            'this message has been reported',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'report',
                                                          style: TextStyle(
                                                              color: Provider.of<
                                                                              Themprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isdarkmode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        ListTile(
                                          title: Text(
                                            'block user',
                                            style: TextStyle(
                                                color:
                                                    Provider.of<Themprovider>(
                                                                context,
                                                                listen: false)
                                                            .isdarkmode
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),
                                          leading: Icon(
                                            Icons.block,
                                            color: Provider.of<Themprovider>(
                                                        context,
                                                        listen: false)
                                                    .isdarkmode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Block user',
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        Themprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isdarkmode
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  content: Text(
                                                    'are you sure that you want to block this user?',
                                                    style: TextStyle(
                                                        color: Provider.of<
                                                                        Themprovider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isdarkmode
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color: Provider.of<
                                                                              Themprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isdarkmode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          firestoreuse()
                                                              .blockuser(widget
                                                                  .reciveruid);
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Text(
                                                            'this user has been blocked',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )));
                                                        },
                                                        child: Text(
                                                          'block',
                                                          style: TextStyle(
                                                              color: Provider.of<
                                                                              Themprovider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isdarkmode
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        ListTile(
                                          title: Text(
                                            'cancel',
                                            style: TextStyle(
                                                color:
                                                    Provider.of<Themprovider>(
                                                                context,
                                                                listen: false)
                                                            .isdarkmode
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),
                                          leading: Icon(
                                            Icons.cancel,
                                            color: Provider.of<Themprovider>(
                                                        context,
                                                        listen: false)
                                                    .isdarkmode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: snapshot.data![index]['senderid'] ==
                                        senderuid
                                    ? Colors.grey.shade400
                                    : Colors.green.shade400,
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                snapshot.data![index]['message'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: MYTEXTFORM(
                        focusenode: focusnode,
                        controller1: mesagecon,
                        hinttext: 'type your message',
                        obscuretext: false),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(1000)),
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: IconButton(
                      onPressed: () async {
                        if (mesagecon.text.isNotEmpty) {
                          await firestoreuse()
                              .sendmessage(widget.reciveruid, mesagecon.text);
                          mesagecon.clear();
                        }
                        scrolltobuttom();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ],
        ));
  }
}
