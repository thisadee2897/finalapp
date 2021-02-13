import 'package:flutter/material.dart';

class Email {
  Email({@required this.email, @required this.id});

  final String id;
  final String email;

  factory Email.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String email = data['email'];
    return Email(email: email, id: documentId);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}