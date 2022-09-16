import 'package:contact_diary_app/globals/globals.dart';
import 'package:contact_diary_app/screens/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../themes/app_theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Contacts",
          style:
              TextStyle(color: (AppTheme.isDark) ? Colors.white : Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.circle,
              color: (AppTheme.isDark) ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                AppTheme.isDark = !AppTheme.isDark;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: (AppTheme.isDark) ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('add_contact_page');
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: (Global.allContacts.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_box_outlined, size: 100),
                  Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                        primary: Colors.amber,
                      ),
                    ),
                    child: SelectableText(
                      "You do not have any contacts yet.",
                      style: TextStyle(
                        color: (AppTheme.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: Global.allContacts.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('detail_page',
                          arguments: Global.allContacts[i]);
                    },
                    leading: CircleAvatar(
                      backgroundImage: (Global.allContacts[i].image != null)
                          ? FileImage(Global.allContacts[i].image as File)
                          : null,
                    ),
                    title: Text(
                        "${Global.allContacts[i].firstName} ${Global.allContacts[i].lastName}"),
                    subtitle: Text("+91 ${Global.allContacts[i].phoneNumber}"),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                  );
                },
              ),
      ),
    );
  }
}
