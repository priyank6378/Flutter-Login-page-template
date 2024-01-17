import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_login_learning/const/route.dart';
import 'package:google_login_learning/firebase_options.dart';
import 'package:google_login_learning/service/auth_providers.dart';
import 'package:google_login_learning/views/login_page_view.dart';
import 'package:google_login_learning/views/main_page_view.dart';
import 'package:google_login_learning/views/signup_page_view.dart';
import 'package:google_login_learning/views/verify_email_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        loginPageRoute: (context) => const LoginPageView(),
        homePageRoute: (context) => const MyHomePage(),
        signupPageRoute: (context) => const SignUpPageView(),
        verifyEmailPageRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          User? curUser = GoogleAuthentication().getUser();
          if (curUser == null) {
            return const LoginPageView();
          }
          if (curUser.emailVerified == false) {
            return const VerifyEmailView();
          }
          return const MainPageView();
        }
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}
