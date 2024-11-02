import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fire_base_mastring/core/function/validator.dart';
import 'package:fire_base_mastring/core/main_widget/ask_have_or_not_have_account.dart';
import 'package:fire_base_mastring/core/main_widget/main_button.dart';
import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerUserName = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 45),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      "Signup your account to continue using the app",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("user name"),
                ),
                MainTextFormField(
                  validate: userNameValidator,
                  controller: controllerUserName,
                  text: "inter your name",
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email"),
                ),
                MainTextFormField(
                  validate: emailValidator,
                  controller: controllerEmail,
                  text: "inter your email",
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password"),
                ),
                MainTextFormField(
                  validate: passwordValidator,
                  controller: controllerPassword,
                  text: "inter your password",
                ),
                CustomButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    if (formState.currentState?.validate() ?? false) {
                      try {
                        isLoading = true;
                        setState(() {});
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: controllerEmail.text,
                          password: controllerPassword.text,
                        );
                        credential.user!.sendEmailVerification();
                        debugPrint(
                            "you must check your email and verification your email");

                        isLoading = false;

                        Navigator.of(context)
                            .pushReplacementNamed(AppKeyRouteNamed.login);
                      } on FirebaseAuthException catch (e) {
                        isLoading = false;
                        setState(() {});
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: e.code.replaceFirst("-", " "),
                          desc: e.message,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                  },
                  text: "Register",
                ),
                AskHaveOrNotHaveAccount(
                  onPressend: () {
                    Navigator.pushReplacementNamed(
                        context, AppKeyRouteNamed.login);
                  },
                  textHaveOrNotHaveAccount: "Do you have an account before? ",
                  textRegisterOrLogin: "Login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
