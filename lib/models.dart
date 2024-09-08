import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String name;
  String desc;
  DateTime date;

  Task(
      {required this.id,
      required this.name,
      required this.desc,
      required this.date});

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      name: data['name'] ?? '',
      desc: data['desc'] ?? '',
      date: (data['date'] as Timestamp)
          .toDate(), 
    );
  }
}
