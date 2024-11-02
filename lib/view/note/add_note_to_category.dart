import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:fire_base_mastring/view/note/note_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage(
      {super.key, required this.docId, required this.categoryFileName});
  final String docId;
  final String categoryFileName;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  Future<void> addNoteFunction() async {
    CollectionReference noteCategories =
        FirebaseFirestore.instance.collection('categories');
    return await noteCategories
        .doc(widget.docId)
        .collection("note")
        .add({
          'note': controller.text,
        })
        .then((value) => debugPrint("note Added"))
        .catchError((error) => debugPrint("Failed to add note: $error"));
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
        title: const Text("Add Note"),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
          child: Column(
            children: [
              MainTextFormField(
                text: "add your note  here",
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
                  addNoteFunction();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NotePage(
                            categoryFileName: widget.categoryFileName,
                            docId: widget.docId);
                      },
                    ),
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
