import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:fire_base_mastring/view/note/note_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditeNoteCategoryPage extends StatefulWidget {
  const EditeNoteCategoryPage(
      {super.key,
      required this.docs,
      required this.oldNote,
      required this.docsNote,
      required this.categoryFileName});
  final String docsNote;
  final String categoryFileName;
  final String docs;
  final String oldNote;
  @override
  State<EditeNoteCategoryPage> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<EditeNoteCategoryPage> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  var categories = FirebaseFirestore.instance.collection('categories');

  Future<void> editCategoryFunction() async {
    await categories
        .doc(widget.docs)
        .collection("note")
        .doc(widget.docsNote)
        .set({
      "note": controller.text,
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    controller.text = widget.oldNote;
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
        title: const Text("edite note"),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
          child: Column(
            children: [
              MainTextFormField(
                text: "edite note here",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NotePage(
                            categoryFileName: widget.categoryFileName,
                            docId: widget.docs);
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
