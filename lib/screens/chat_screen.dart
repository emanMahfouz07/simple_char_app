import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar/models/messages.dart';
import 'package:scholar/widgets/constants.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'chatId';

  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromDocument(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icons8-graduation-cap-50.png',
                  ),
                  const Text('Chats')
                ],
              ),
              centerTitle: true,
              backgroundColor: const Color(0xffCDB4DB),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : SecondChatBubble(
                                message: messagesList[index],
                              );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {}),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor)),
                    ),
                    onSubmitted: (data) {
                      messages.add({
                        'messages': data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('Loading.....');
        }
      },
    );
  }
}
