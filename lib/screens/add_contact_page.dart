import 'dart:io';

import 'package:contact_diary_app/globals/globals.dart';
import 'package:contact_diary_app/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../themes/app_theme.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _picker = ImagePicker();
  File? image;

  final GlobalKey<FormState> _addContactFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;

  TextStyle labelStyle = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: (AppTheme.isDark) ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Add",
          style:
              TextStyle(color: (AppTheme.isDark) ? Colors.white : Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: (AppTheme.isDark) ? Colors.white : Colors.black,
            ),
            onPressed: () {
              if (_addContactFormKey.currentState!.validate()) {
                _addContactFormKey.currentState!.save();

                Contact c1 = Contact(
                  firstName: firstName,
                  lastName: lastName,
                  phoneNumber: phoneNumber,
                  email: email,
                  image: image,
                );

                setState(() {
                  Global.allContacts.add(c1);
                });

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  XFile? pickedImage =
                      await _picker.pickImage(source: ImageSource.camera);

                  setState(() {
                    image = File(pickedImage!.path);
                  });
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: (image != null) ? FileImage(image!) : null,
                  child: (image != null) ? const Text("") : const Text("Add"),
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Form(
                    key: _addContactFormKey,
                    child: Column(
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
                )),
          ],
        ),
      ),
    );
  }
}
