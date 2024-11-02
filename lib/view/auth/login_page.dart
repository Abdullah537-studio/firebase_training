import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fire_base_mastring/core/function/validator.dart';
import 'package:fire_base_mastring/core/main_widget/ask_have_or_not_have_account.dart';
import 'package:fire_base_mastring/core/main_widget/main_button.dart';
import 'package:fire_base_mastring/core/main_widget/main_text_form_field.dart';
import 'package:fire_base_mastring/core/main_widget/main_use_google_to_auth_button.dart';
import 'package:fire_base_mastring/core/string/app_route_named_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacementNamed(context, AppKeyRouteNamed.homePage);
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
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
                      "Login",
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
                      "Login to continue using the app",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: controllerEmail.text);
                      },
                      child: const Text(
                        "forget password?",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    if (formState.currentState?.validate() ?? false) {
                      try {
                        isLoading = true;
                        setState(() {});
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: controllerEmail.text,
                                password: controllerPassword.text);

                        if (credential.user!.emailVerified) {
                          isLoading = false;

                          Navigator.pushReplacementNamed(
                              context, AppKeyRouteNamed.homePage);
                        } else {
                          isLoading = false;
                          setState(() {});

                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.bottomSlide,
                            title: "email verified",
                            desc:
                                "you must verified your email before login we send email on your account go and confirm to continue",
                          ).show();
                        }
                      } on FirebaseAuthException catch (e) {
                        isLoading = false;

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.bottomSlide,
                          title: e.code.replaceFirst("-", " "),
                          desc: e.message,
                        ).show();
                        setState(() {});
                      }
                    }
                  },
                  text: "Login",
                ),
                ButtonGoogleToAuth(
                  text: "Login with googel",
                  onPressed: () {
                    signInWithGoogle(context);
                  },
                ),
                AskHaveOrNotHaveAccount(
                  onPressend: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppKeyRouteNamed.signup,
                    );
                  },
                  textHaveOrNotHaveAccount: "Do you not have account yet? ",
                  textRegisterOrLogin: "Register",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
