import 'package:meta/meta.dart';
import 'package:flutter_appc/app/home/models/email.dart';
import 'package:flutter_appc/app/home/models/phone.dart';
import 'package:flutter_appc/app/home/models/place.dart';

class Profile {
  Profile(
      {@required this.id,
      @required this.image,
      @required this.phones,
      @required this.email,
      @required this.address,
      @required this.name});

  final String id;
  final String image;
  final List<Phone> phones;
  final List<Email> email;
  final List<Place> address;
  final String name;

  factory Profile.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String image = data['ratePerHour'];
    final List<Phone> phoneNumber = data['phones'];
    final List<Email> email = data['email'];
    final List<Place> address = data['address'];
    return Profile(
        id: documentId,
        name: name,
        image: image,
        phones: phoneNumber,
        email: email,
        address: address);
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'phone': phones,
      'email': email,
      'address': address,
      'name': name,
    };
  }
}
