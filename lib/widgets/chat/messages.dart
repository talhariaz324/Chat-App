import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt',
              descending:
                  true) // It will store according to time and show in decending order in our UI
          .snapshots(), // For Live we use snapshots
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            message:  chatDocs[index]['text'],
            userName:  chatDocs[index]['username'],
            userImage:  chatDocs[index]['userImage'],
            isMe: chatDocs[index]['userId'] == user!.uid,
             key:  ValueKey(chatDocs[index].id), //Well, Keys are the ones to preserve state when widgets move around the widget tree. It is used to preserve the user scroll location or keeping state when modifying a collection.
          ),
        );
      },
    );
  }
}
