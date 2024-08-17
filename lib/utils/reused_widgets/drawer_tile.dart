import 'package:flutter/material.dart';

class DrawerTile {
  Widget tile(BuildContext context, String title, IconData icons) {
    return ListTile(
      leading: Icon(icons),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
