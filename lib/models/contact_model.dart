import 'dart:io';

class Contact {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final File? image;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    this.image,
  });
}
