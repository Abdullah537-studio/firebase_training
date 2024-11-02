import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_mastring/core/main_widget/custom_note_category.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:fire_base_mastring/view/note/add_note_to_category.dart';
import 'package:fire_base_mastring/view/note/edite_note_to_category.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage(
      {super.key, required this.categoryFileName, required this.docId});
  final String categoryFileName;
  final String docId;
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  Future<void> getData() async {
    isLoading = true;
    setState(() {});
    await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docId)
        .collection("note")
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        data = querySnapshot.docs;
      },
    );
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(
                docId: widget.docId,
                categoryFileName: widget.categoryFileName,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(widget.categoryFileName),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppKeyRouteNamed.homePage,
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                )
              : RefreshIndicator(
                  color: Colors.orange,
                  onRefresh: () async {
                    await getData();
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CustomNoteCategoryWidget(
                        longPress: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.bottomSlide,
                            title: "Edite Note",
                            desc: "are your  delete or update this note",
                            btnOkOnPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditeNoteCategoryPage(
                                      categoryFileName: widget.categoryFileName,
                                      docs: widget.docId,
                                      oldNote: data[index]["note"],
                                      docsNote: data[index].id,
                                    );
                                  },
                                ),
                              );
                            },
                            btnOkText: "Edit",
                            btnCancelText: "Delete",
                            btnOkColor: Colors.orange,
                            btnCancelColor: Colors.red,
                            btnCancelOnPress: () {
                              FirebaseFirestore.instance
                                  .collection("categories")
                                  .doc(widget.docId)
                                  .collection("note")
                                  .doc(data[index].id)
                                  .delete();
                            },
                          ).show();
                        },
                        text: data[index]["note"],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
