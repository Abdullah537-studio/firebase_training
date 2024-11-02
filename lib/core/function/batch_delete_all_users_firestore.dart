import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> batchDelete() {
  CollectionReference user = FirebaseFirestore.instance.collection("users");

  WriteBatch batch = FirebaseFirestore.instance.batch();

  return user.get().then((querySnapshot) {
    querySnapshot.docs.forEach((document) {
      batch.delete(document.reference);
    });

    return batch.commit();
  });
}
