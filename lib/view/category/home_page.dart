import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_mastring/core/main_widget/card_file_category_info.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:fire_base_mastring/view/category/edit_category_page.dart';
import 'package:fire_base_mastring/view/note/note_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      data = querySnapshot.docs;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    getData();
    setState(() {});
    super.initState();
  }

  signOutFunction() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.pushNamed(context, AppKeyRouteNamed.addCategory);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text("home page"),
        actions: [
          IconButton(
              onPressed: () {
                try {
                  signOutFunction();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppKeyRouteNamed.login,
                    (route) => false,
                  );
                } catch (e) {
                  debugPrint("Error deleting user: $e");
                }
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : RefreshIndicator(
                color: Colors.orange,
                onRefresh: () {
                  return getData();
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FileCategoryCardInfo(
                      onPreesed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NotePage(
                                docId: data[index].id,
                                categoryFileName: data[index]["name"],
                              );
                            },
                          ),
                        );
                      },
                      longPress: () {
                        debugPrint("loginPress to delete category");
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          title: "delete category",
                          desc: "are your sure delete this category",
                          btnOkOnPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditCategoryPage(
                                    docs: data[index].id,
                                    oldName: data[index]["name"],
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
                                .doc(data[index].id)
                                .delete();
                            Navigator.pushReplacementNamed(
                                context, AppKeyRouteNamed.homePage);
                          },
                        ).show();
                      },
                      text: data[index]["name"],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
