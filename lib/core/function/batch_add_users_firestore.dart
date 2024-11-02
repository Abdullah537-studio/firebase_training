import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> batchAddUsers() async {
  CollectionReference user = FirebaseFirestore.instance.collection("users");
  DocumentReference document1 = user.doc("1");
  DocumentReference document2 = user.doc("2");
  DocumentReference document3 = user.doc("3");
  WriteBatch batch = FirebaseFirestore.instance.batch();

  return await user.get().then((QuerySnapshot querySnapshot) {
    batch.set(document1, {
      "name": "userAddBatch1",
      "age": 22,
      "balance": 40000,
    });
    batch.set(document2, {
      "name": "userAddBatch2",
      "age": 52,
      "balance": 20000,
    });
    batch.set(document3, {
      "name": "userAddBatch3",
      "age": 66,
      "balance": 100000,
    });

    return batch.commit();
  }).then(
    (value) {},
  );
}
