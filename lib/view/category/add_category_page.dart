import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addCategoryFunction() async {
    return await categories
        .add({
          'name': controller.text,
          'id': FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
          child: Column(
            children: [
              MainTextFormField(
                text: "add your category name here",
                controller: controller,
                validate: (value) {
                  if (value?.isEmpty ?? false) {
                    return "this field is required";
                  } else {
                    return null;
                  }
                },
              ),
              InkWell(
                onTap: () {
                  addCategoryFunction();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppKeyRouteNamed.homePage,
                    (route) {
                      return false;
                    },
                  );
                },
                child: Container(
                  width: 90,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
