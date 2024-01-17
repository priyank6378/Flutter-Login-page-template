import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_login_learning/const/route.dart';
import 'package:google_login_learning/const/styles/button_styles.dart';
import 'package:google_login_learning/service/auth_exceptions.dart';
import 'package:google_login_learning/service/auth_providers.dart';
import 'package:google_login_learning/utilities/dialogs/error_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({super.key});

  @override
  State<SignUpPageView> createState() => SignUpPageViewState();
}

class SignUpPageViewState extends State<SignUpPageView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
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
                              "C r e a t e   A c c o u n t",
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
                                    await FirebaseAuthProvider().signUp(
                                      email: email,
                                      password: password,
                                    );
                                    FirebaseAuthProvider().verifyEmail();
                                    Navigator.of(context)
                                        .pushNamed(verifyEmailPageRoute);
                                  } on WeakPasswordAuthException {
                                    await showErrorDialog(
                                        context, "Weak password");
                                  } on EmailAlreadyInUseAuthException {
                                    await showErrorDialog(
                                        context, "Email already in use");
                                  } on InvalidEmailAuthException {
                                    await showErrorDialog(
                                        context, "Invalid Email");
                                  } on GenericAuthException {
                                    await showErrorDialog(
                                        context, "Failed to register!");
                                  }
                                },
                                child: const Text(
                                  "S i g n   U p",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text("O R"),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xffe5e7eb),
                                  ),
                                  child: TextButton(
                                      style: customButtonStyle1,
                                      onPressed: () async {
                                        await GoogleAuthentication()
                                            .signInWithGoogle();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                homePageRoute,
                                                (route) => false);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            MdiIcons.google,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Sign Up with Google",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already a user?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(loginPageRoute);
                                  },
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            )
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
      ),
    );
  }
}
