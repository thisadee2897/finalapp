import 'package:meta/meta.dart';
import 'package:flutter_appc/app/home/models/birthday.dart';
import 'package:flutter_appc/app/home/models/email.dart';
import 'package:flutter_appc/app/home/models/entry.dart';
import 'package:flutter_appc/app/home/models/job.dart';
import 'package:flutter_appc/app/home/models/phone.dart';
import 'package:flutter_appc/app/home/models/place.dart';
import 'package:flutter_appc/services/api_path.dart';
import 'package:flutter_appc/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Future<void> setPhone(Phone phones);

  Future<void> setBirthday(Birthday birthday);

  Future<void> setEmail(Email email);

  Future<void> setAddress(Place address);

  Future<void> setEntry(Entry entry);

  Future<void> deleteJob(Job job);

  Future<void> deletePhone(Phone phone);

  Future<void> deleteEmail(Email email);

  Future<void> deleteAddress(Place address);

  Future<void> deleteEntry(Entry entry);

  List<String> phoneList();

  Stream<List<Job>> jobsStream();

  Stream<List<Birthday>> birthdayStream();

  Stream<List<Phone>> phonesStream();

  Stream<List<Email>> emailsStream();

  Stream<List<Place>> addresssStream();

  Stream<Job> jobStream({@required String jobId});

  Stream<List<Entry>> entriesStream({Job job});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  bool seen_ads = false;

  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) => _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) async {
    // delete where entry.jobId == job.jobId
    final allEntries = await entriesStream(job: job).first;
    for (Entry entry in allEntries) {
      if (entry.jobId == job.id) {
        await deleteEntry(entry);
      }
    }
    // delete job
    await _service.deleteData(path: APIPath.job(uid, job.id));
  }

  @override
  Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
        path: APIPath.job(uid, jobId),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Phone>> phonesStream() => _service.collectionStream(
        path: APIPath.phones(uid),
        builder: (data, documentId) => Phone.fromMap(data, documentId),
      );

  @override
  Stream<List<Email>> emailsStream() => _service.collectionStream(
        path: APIPath.emails(uid),
        builder: (data, documentId) => Email.fromMap(data, documentId),
      );

  @override
  Future<void> setEntry(Entry entry) => _service.setData(
        path: APIPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) => _service.deleteData(
        path: APIPath.entry(uid, entry.id),
      );

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _service.collectionStream<Entry>(
        path: APIPath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );

  @override
  Stream<List<Email>> emailStream() => _service.collectionStream(
        path: APIPath.emails(uid),
        builder: (data, documentId) => Email.fromMap(data, documentId),
      );

  @override
  Future<void> deletePhone(Phone phone) => _service.deleteData(
        path: APIPath.phone(uid, phone.id),
      );

  @override
  Future<void> deleteAddress(Place address) => _service.deleteData(
        path: APIPath.address(uid, address.id),
      );

  @override
  Future<void> deleteEmail(Email email) => _service.deleteData(
        path: APIPath.email(uid, email.id),
      );

  @override
  Stream<List<Place>> addresssStream() => _service.collectionStream(
        path: APIPath.addresss(uid),
        builder: (data, documentId) => Place.fromMap(data, documentId),
      );

  @override
  Future<void> setPhone(Phone phone) => _service.setData(
        path: APIPath.phone(uid, phone.id),
        data: phone.toMap(),
      );

  @override
  Future<void> setEmail(Email email) => _service.setData(
        path: APIPath.email(uid, email.id),
        data: email.toMap(),
      );

  @override
  Future<void> setAddress(Place address) => _service.setData(
        path: APIPath.address(uid, address.id),
        data: address.toMap(),
      );

  @override
  Future<void> setBirthday(Birthday birthday) => _service.setData(
        path: APIPath.birthday(uid, birthday.id),
        data: birthday.toMap(),
      );

  @override
  Stream<List<Birthday>> birthdayStream() => _service.collectionStream(
        path: APIPath.birthdays(uid),
        builder: (data, documentId) => Birthday.fromMap(data, documentId),
      );

  @override
  List<String> phoneList() {
    // TODO: implement phoneList
    throw UnimplementedError();
  }
}
