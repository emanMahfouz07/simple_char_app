import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String id;

  Message({
    required this.message,
    required this.id,
  });
  factory Message.fromDocument(DocumentSnapshot jsonData) {
    return Message(
        message: jsonData.data().toString().contains('messages')
            ? jsonData.get('messages')
            : '',
        id: jsonData.data().toString().contains('id')
            ? jsonData.get('id')
            : '');
  }
}
