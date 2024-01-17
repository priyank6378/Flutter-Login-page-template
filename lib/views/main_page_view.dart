import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_login_learning/const/route.dart';
import 'package:google_login_learning/service/auth_providers.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key, User? user});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  User? user = GoogleAuthentication().getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Text(user?.email ?? "none"),
          TextButton(
            onPressed: () {
              GoogleAuthentication().logoutGoogleAccount();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out"),
                ),
              );
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginPageRoute, (route) => false);
            },
            child: const Text("Logout"),
          ),
        ]),
      ),
    );
  }
}
