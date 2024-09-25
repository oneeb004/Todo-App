import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/models/to_do_model.dart';

class DatabaseService {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todos");

  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentReference> addToDoTask(
    String title,
    String discription,
  ) async {
    return await todoCollection.add({
      "uid": user!.uid,
      "title": title,
      "discription": discription,
      "completed": false,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  //update

  Future<void> updateToDoTask(
      String id, String title, String discription) async {
    final updatetodoCollection =
        FirebaseFirestore.instance.collection("todos").doc(id);

    return updatetodoCollection.update({
      "title": title,
      "discription": discription,
    });
  }

  Future<void> updateToDoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({
      "completed": completed,
    });
  }

  Future<void> deleteToDoTask(String id) async {
    return await todoCollection.doc(id).delete();
  }

  Stream<List<ToDo>> get todos {
    return todoCollection
        .where("uid", isEqualTo: user!.uid)
        .where("completed", isEqualTo: false)
        .snapshots()
        .map((_todoListFromSnapShot));
  }

  Stream<List<ToDo>> get completedtodos {
    return todoCollection
        .where("uid", isEqualTo: user!.uid)
        .where("completed", isEqualTo: true)
        .snapshots()
        .map((_todoListFromSnapShot));
  }

  List<ToDo> _todoListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ToDo(
          id: doc.id,
          title: doc["title"] ?? "",
          discription: doc["discription"] ?? "",
          completed: doc["completed"] ?? false,
          timeStamp: doc["createdAt"] ?? "");
    }).toList();
  }
}
