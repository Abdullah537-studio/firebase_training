// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fire_base_mastring/core/function/batch_delete_all_users.dart';
// import 'package:fire_base_mastring/core/function/get_user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_mastring/core/function/add_single_user_firestore.dart';
import 'package:fire_base_mastring/core/function/batch_delete_all_users_firestore.dart';
import 'package:fire_base_mastring/core/main_widget/loading_indicator.dart';
import 'package:fire_base_mastring/core/main_widget/main_button.dart';
import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerUserName = TextEditingController();
    TextEditingController _controllerUserAge = TextEditingController();
    TextEditingController _controllerUserBalance = TextEditingController();
    FloatingActionButton _floatingActionButton = FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainTextFormField(
                      text: "inter username",
                      controller: _controllerUserName,
                      validate: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        }
                        return "this field is required";
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    MainTextFormField(
                      text: "inter user age",
                      controller: _controllerUserAge,
                      validate: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        }
                        return "this field is required";
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    MainTextFormField(
                      text: "inter user balance",
                      controller: _controllerUserBalance,
                      validate: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        }
                        return "this field is required";
                      },
                    ),
                    CustomButton(
                      text: "submit",
                      onPressed: () {
                        int userBalance =
                            int.parse(_controllerUserBalance.text);
                        int userAge = int.parse(_controllerUserAge.text);
                        String userName = _controllerUserName.text;
                        addSingleUser(
                          userName: userName,
                          age: userAge,
                          balance: userBalance,
                        );
                        Navigator.pop(context);
                      },
                      isLoading: false,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );

    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection("users").snapshots();
    return Scaffold(
      floatingActionButton: _floatingActionButton,
      appBar: AppBar(
        title: Text("filter"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  title: "Delete all users",
                  desc: "are you sure delete all users??   you cant reusers",
                  dialogType: DialogType.warning,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    batchDelete();
                  },
                ).show();
              })
        ],
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var data;
          if (snapshot.hasError) {
            return Center(child: Text("some thing has rong"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator(color: Colors.orange);
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                data = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 22, horizontal: 17),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(22)),
                  child: ListTile(
                    title: Text(
                      data["name"],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "age: ${data["age"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      "${data["balance"]} \$",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            );
            // ListView(
            //   children: snapshot.data!.docs.map(
            //     (DocumentSnapshot document) {
            //       Map<String, dynamic> data =
            //           document.data()! as Map<String, dynamic>;
            //       return Container(
            //         margin: EdgeInsets.symmetric(vertical: 22, horizontal: 17),
            //         decoration: BoxDecoration(
            //             color: Colors.orange,
            //             border: Border.all(color: Colors.transparent),
            //             borderRadius: BorderRadius.circular(22)),
            //         child: ListTile(
            //           title: Text(
            //             data["name"],
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           subtitle: Text(
            //             "age: ${data["age"]}",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           trailing: Text(
            //             "${data["balance"]} \$",
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ).toList(),
            // );
          }
        },
      ),
    );
  }
}
