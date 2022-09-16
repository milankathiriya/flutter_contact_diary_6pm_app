import 'package:contact_diary_app/globals/globals.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../models/contact_model.dart';
import '../themes/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextStyle labelStyle = const TextStyle(fontSize: 18);

  final GlobalKey<FormState> _updateContactFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(flex: 5),
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      (res.image != null) ? FileImage(res.image as File) : null,
                ),
                const Spacer(flex: 1),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Global.allContacts.remove(res);

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    validateAndUpdate(data: res);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "${res.firstName} ${res.lastName}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  "+91 ${res.phoneNumber}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black, indent: 20, endIndent: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.green,
                  mini: true,
                  onPressed: () async {
                    Uri url = Uri.parse("tel:+91${res.phoneNumber}");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Can't be launched..."),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.call),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.amber,
                  mini: true,
                  onPressed: () async {
                    Uri url = Uri.parse("sms:+91${res.phoneNumber}");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Can't be launched..."),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.message),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.lightBlue,
                  mini: true,
                  onPressed: () async {
                    Uri url = Uri.parse(
                        "mailto:${res.email}?subject=Demo&body=Hello");

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Can't be launched..."),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.email),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.deepOrangeAccent,
                  mini: true,
                  onPressed: () async {
                    await Share.share("+91 ${res.phoneNumber}");
                  },
                  child: const Icon(Icons.share),
                ),
              ],
            ),
            const Divider(color: Colors.black, indent: 20, endIndent: 20),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }

  validateAndUpdate({required Contact data}) {
    _firstNameController.text = data.firstName!;
    _lastNameController.text = data.lastName!;
    _phoneController.text = data.phoneNumber!;
    _emailController.text = data.email!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Update Contact"),
        ),
        content: Form(
          key: _updateContactFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                "First Name",
                style: labelStyle,
              ),
              TextFormField(
                controller: _firstNameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your first name...";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    firstName = val;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Enter your first name..."),
              ),
              const SizedBox(height: 20),
              Text(
                "Last Name",
                style: labelStyle,
              ),
              TextFormField(
                controller: _lastNameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your last name...";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    lastName = val;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Enter your last name..."),
              ),
              const SizedBox(height: 20),
              Text(
                "Phone Number",
                style: labelStyle,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your phone number...";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    phoneNumber = val;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Enter your phone number..."),
              ),
              const SizedBox(height: 20),
              Text(
                "Email",
                style: labelStyle,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your last name...";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Enter your email..."),
              ),
            ],
          ),
        ),
        actions: [
          Theme(
            data: ThemeData(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Colors.lightBlue)),
            child: ElevatedButton(
              child: Text("Update"),
              onPressed: () {
                if (_updateContactFormKey.currentState!.validate()) {
                  _updateContactFormKey.currentState!.save();

                  Contact c = Contact(
                      firstName: firstName,
                      lastName: lastName,
                      phoneNumber: phoneNumber,
                      email: email);

                  int i = Global.allContacts.indexOf(data);

                  Global.allContacts[i] = c;

                  Navigator.of(context).pop();

                  _firstNameController.clear();
                  _lastNameController.clear();
                  _phoneController.clear();
                  _emailController.clear();

                  setState(() {
                    firstName = "";
                    lastName = "";
                    phoneNumber = "";
                    email = "";
                  });
                }
              },
            ),
          ),
          Theme(
            data: ThemeData(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Colors.lightBlue)),
            child: ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();

                _firstNameController.clear();
                _lastNameController.clear();
                _phoneController.clear();
                _emailController.clear();

                setState(() {
                  firstName = "";
                  lastName = "";
                  phoneNumber = "";
                  email = "";
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
