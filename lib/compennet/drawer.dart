import 'package:chatapp/servises/auth.dart';
import 'package:chatapp/pages/settings.dart';
import 'package:chatapp/thems/themprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MYDrawer extends StatelessWidget {
  const MYDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),

          //logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Icon(
              Icons.message,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          //home list tile
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text(
                '  HOME',
                style: TextStyle(
                    color: Provider.of<Themprovider>(context).isdarkmode
                        ? Colors.white
                        : Colors.black),
              ),
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          //setting lidt tile
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text(
                '  Settings',
                style: TextStyle(
                    color: Provider.of<Themprovider>(context).isdarkmode
                        ? Colors.white
                        : Colors.black),
              ),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings(),
                ));
              },
            ),
          ),
          //logout
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text(
                '  Logout',
                style: TextStyle(
                    color: Provider.of<Themprovider>(context).isdarkmode
                        ? Colors.white
                        : Colors.black),
              ),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                Auth().singout(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
