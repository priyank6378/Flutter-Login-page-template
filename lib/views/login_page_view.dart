import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_login_learning/const/route.dart';
import 'package:google_login_learning/const/styles/button_styles.dart';
import 'package:google_login_learning/service/auth_exceptions.dart';
import 'package:google_login_learning/service/auth_providers.dart';
import 'package:google_login_learning/utilities/dialogs/error_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9fafb),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const Positioned.fill(
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/login_background.webp"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: const Color(0x00d1d5db),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "A u t h e n t i c a t i o n",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffe5e7eb),
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffe5e7eb),
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffe5e7eb),
                            ),
                            child: TextButton(
                              style: customButtonStyle1,
                              onPressed: () async {
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                try {
                                  await FirebaseAuthProvider()
                                      .logIn(email: email, password: password);
                                  final user =
                                      FirebaseAuthProvider().currentUser();
                                  if (user != null) {
                                    if (user.emailVerified) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              homePageRoute, (route) => false);
                                    } else {
                                      Navigator.of(context)
                                          .pushNamed(verifyEmailPageRoute);
                                    }
                                  }
                                } on InvalidCredentialsAuthException {
                                  await showErrorDialog(
                                      context, "Invalid Credentials");
                                } on GenericAuthException {
                                  await showErrorDialog(
                                      context, "Authentication Error");
                                }
                              },
                              child: const Text(
                                "L o g i n",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.425 -
                                        5,
                                height:
                                    MediaQuery.of(context).size.width * 0.425 -
                                        5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffe5e7eb),
                                ),
                                child: TextButton(
                                  style: customButtonStyle1,
                                  onPressed: () async {
                                    await GoogleAuthentication().signInWithGoogle();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            homePageRoute, (route) => false);
                                  },
                                  child: Icon(
                                    MdiIcons.google,
                                    size: 100,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.425 -
                                        5,
                                height:
                                    MediaQuery.of(context).size.width * 0.425 -
                                        5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffe5e7eb),
                                ),
                                child: TextButton(
                                  style: customButtonStyle1,
                                  onPressed: () {
                                    // TODO: write the logic for FACEBOOK LOGIN here.
                                  },
                                  child: Icon(
                                    MdiIcons.facebook,
                                    size: 100,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 5),
                              TextButton(
                                style: customButtonStyle1,
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      signupPageRoute, (route) => false);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
