import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_login_learning/const/route.dart';
import 'package:google_login_learning/const/styles/button_styles.dart';
import 'package:google_login_learning/service/auth_providers.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/login_background.webp"),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please verify your email! 👇",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(221, 201, 117, 184),
                      Color.fromARGB(221, 188, 212, 121),
                    ]),
                    // color: Color.fromARGB(221, 82, 132, 232),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      FirebaseAuthProvider().verifyEmail();
                    },
                    style: customButtonStyle1,
                    child: const Text(
                      "V e r i f y   E m a i l",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () async {
                      await FirebaseAuthProvider().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginPageRoute, (route) => false);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        Text(
                          " Log Out",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      final user = FirebaseAuthProvider().currentUser();
                      if (user!.emailVerified == true) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            homePageRoute, (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Email not verified yet!"),
                          ),
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                        Text(
                          " Verified! go to Home.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
