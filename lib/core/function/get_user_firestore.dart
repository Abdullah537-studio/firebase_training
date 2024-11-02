import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> getUsers(
    {required List<QueryDocumentSnapshot> data,
    required bool isLoading}) async {
  CollectionReference user = FirebaseFirestore.instance.collection("users");

  QuerySnapshot userData = await user.get();

  // .orderBy("age", descending: true)
  // .where("age", isGreaterThan: 18)
  data = userData.docs;
  isLoading = false;
}
