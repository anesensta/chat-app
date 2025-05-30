import 'package:chatapp/pages/block.dart';
import 'package:chatapp/thems/themprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            foregroundColor: Provider.of<Themprovider>(context).isdarkmode
                ? Colors.white
                : Colors.black),
        body: Column(
          children: [
            Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark mode   '),
                      CupertinoSwitch(
                          value:
                              Provider.of<Themprovider>(context, listen: false)
                                  .isdarkmode,
                          onChanged: (e) {
                            return Provider.of<Themprovider>(context,
                                    listen: false)
                                .swithbutton();
                          })
                    ])),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Block(),
                ));
              },
              child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Block list   '),
                        Icon(Icons.arrow_forward),
                      ])),
            ),
          ],
        ));
  }
}
