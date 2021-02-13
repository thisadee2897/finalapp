import 'package:flutter/material.dart';

class Place {
  Place({@required this.address, @required this.id});

  final String id;
  final String address;

  factory Place.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String address = data['address'];
    return Place(address: address, id: documentId);
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
    };
  }
}