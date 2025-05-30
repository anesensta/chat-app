

import "package:chatapp/compennet/message.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class firestoreuse {
  //instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
//get all useres stream
  Stream<List> getuser() {
    return _firestore.collection('useres').snapshots().map(
      (event) {
        return event.docs
            .where(
          (element) => element.data()['email'] != _auth.currentUser!.email,
        )
            .map(
          (e) {
            final User = e.data();
            return User;
          },
        ).toList();
      },
    );
  }

//get all useres exsepet block list stream
  Stream<List> useresexpetblock() {
    final curreentuser = _auth.currentUser!.uid;
    return _firestore
        .collection('useres')
        .doc(curreentuser)
        .collection('block')
        .snapshots()
        .asyncMap(
      (event) async {
        final blockuseresid = event.docs.map(
          (e) {
            return e.id;
          },
        ).toList();
        final useres = await _firestore.collection('useres').get();
        return useres.docs
            .where((element) =>
                element.data()['email'] != _auth.currentUser!.email &&
                !blockuseresid.contains(element.id))
            .map(
          (e) {
            final User = e.data();
            return User;
          },
        ).toList();
      },
    );
  }

//send message
  Future sendmessage(String reciverid, String message1) async {
//current usser
    final currentuserid = _auth.currentUser!.uid;
    final currentuseremail = _auth.currentUser!.email;
    Timestamp timestamp = Timestamp.now();
//creat message
    Message message = Message(
        currentuseremail!, currentuserid, reciverid, message1, timestamp);
//room privat
    List ids = [currentuserid, reciverid];
    ids.sort();
    String chatromid = ids.join('_');

//send message
    await _firestore
        .collection('chatromm')
        .doc(chatromid)
        .collection('messages')
        .add(message.tomap());
  }

  //get message
  Stream<List> getmessage(String reciveruid, String senderuid) {
    List ids = [reciveruid, senderuid];
    ids.sort();
    String chatromid = ids.join('_');
    return _firestore
        .collection('chatromm')
        .doc(chatromid)
        .collection('messages')
        .orderBy('timetamp', descending: false)
        .snapshots()
        .map(
      (event) {
        return event.docs.map(
          (e) {
            final messagesend = e.data();
            messagesend['messageid'] = e.id;
            return messagesend;
          },
        ).toList();
      },
    );
  }

  // report methode
  Future reportmessage(String messageid, String userid) async {
    String currentuserid = _auth.currentUser!.uid;
    final report = {
      'messageid': messageid,
      'reportedby': currentuserid,
      'sender': userid,
      'time': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('report').add(report);
  }

  // block methode
  Future blockuser(
    String userid,
  ) async {
    final currentuser = _auth.currentUser!.uid;
    await _firestore
        .collection('useres')
        .doc(currentuser)
        .collection('block')
        .doc(userid)
        .set({'userid': userid, 'time': Timestamp.now()});
  }

  // unblock
  Future unblockuser(String userid) async {
    final currentuser = _auth.currentUser!.uid;
    await _firestore
        .collection('useres')
        .doc(currentuser)
        .collection('block')
        .doc(userid)
        .delete();
  }

  //stream block list
  Stream<List> blocklist(String userid) {
    final currentuser = _auth.currentUser!.uid;
    return _firestore
        .collection('useres')
        .doc(currentuser)
        .collection('block')
        .snapshots()
        .asyncMap(
      (event) async {
        List blocklist = [];
        for (var doc in event.docs) {
          final blockdata = doc.data();
          final blockid = doc.id;
          final userdoc =
              await _firestore.collection('useres').doc(blockid).get();
          blockdata['email'] = userdoc.data()!['email'];
          blocklist.add(blockdata);
        }
        return blocklist;
      },
    );
  }
}
