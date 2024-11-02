import 'package:fire_base_mastring/core/main_widget/main_button.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:fire_base_mastring/view/auth/login_page.dart';
import 'package:fire_base_mastring/view/auth/signup_page.dart';
import 'package:fire_base_mastring/view/category/add_category_page.dart';
import 'package:fire_base_mastring/view/category/home_page.dart';
import 'package:fire_base_mastring/view/cloudStorage/image_picker_page.dart';
import 'package:fire_base_mastring/view/filter/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('-------------------------User is currently signed out!');
      } else {
        debugPrint('-------------------------User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.white),
        )),
        routes: {
          AppKeyRouteNamed.login: (context) => const LoginPage(),
          AppKeyRouteNamed.signup: (context) => const Signup(),
          AppKeyRouteNamed.homePage: (context) => const HomePage(),
          AppKeyRouteNamed.addCategory: (context) => const AddCategory(),
          AppKeyRouteNamed.filterPage: (context) => const FilterPage(),
          AppKeyRouteNamed.imagePicker: (context) => const ImagePickerPage(),
        },
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: ChooseFeatureOfFirebase(),
      ),
    );
  }
}

class ChooseFeatureOfFirebase extends StatelessWidget {
  const ChooseFeatureOfFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose feature"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            CustomButton(
              text: "Go to filter page",
              onPressed: () {
                Navigator.pushNamed(context, AppKeyRouteNamed.filterPage);
              },
              isLoading: false,
            ),
            CustomButton(
              text: "Go to note page",
              onPressed: () {
                if (FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified) {
                  Navigator.pushNamed(context, AppKeyRouteNamed.homePage);
                } else {
                  Navigator.pushNamed(context, AppKeyRouteNamed.login);
                }
              },
              isLoading: false,
            ),
            CustomButton(
              text: "Go to image picker page",
              onPressed: () {
                Navigator.pushNamed(context, AppKeyRouteNamed.imagePicker);
              },
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }
}
