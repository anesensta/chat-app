import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderemail;
  final String senderid;
  final String reciverid;
  final String message;
  final Timestamp timestamp;

  Message(
    this.senderemail,
    this.senderid,
    this.reciverid,
    this.message,
    this.timestamp,
  );

  Map<String, dynamic> tomap() {
    return {
      'senderemail': senderemail,
      'senderid': senderid,
      'reciverid': reciverid,
      'message': message,
      'timetamp': timestamp,
    };
  }
}
