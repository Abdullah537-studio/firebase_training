import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage(
      {super.key, required this.docs, required this.oldName});
  final String docs;
  final String oldName;
  @override
  State<EditCategoryPage> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<EditCategoryPage> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  var categories = FirebaseFirestore.instance.collection('categories');

  Future<void> editCategoryFunction() async {
    await categories.doc(widget.docs).set({
      "name": controller.text,
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    controller.text = widget.oldName;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
                  editCategoryFunction();
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
                      "Edit",
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
