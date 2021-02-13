import 'package:flutter/material.dart';

class Phone {
  Phone({@required this.phoneNumber, @required this.id});

  final String id;
  final String phoneNumber;

  factory Phone.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String phoneNumber = data['phoneNumber'];
    return Phone(id: documentId, phoneNumber: phoneNumber);
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
    };
  }
}