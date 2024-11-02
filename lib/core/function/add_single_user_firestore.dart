import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addSingleUser(
    {required String userName, required int age, required int balance}) async {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  users.add({
    "name": userName,
    "age": age,
    "balance": balance,
  });
}
