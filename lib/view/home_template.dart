import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/routes.dart';
import 'package:cligo/features/bottom_navigation.dart' as features;
import 'package:cligo/features/logout.dart' as features;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'dart:developer' as devtools show log;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum NavAction { logout }

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, profileRoute);
                },
                icon: Image.asset(defaultAvatar)),
            PopupMenuButton<NavAction>(
              icon: const Icon(Icons.settings),
              onSelected: (value) async {
                switch (value) {
                  case NavAction.logout:
                    final shouldLogout =
                        await features.showLogoutDialog(context);
                    if (shouldLogout) {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<NavAction>(
                      value: NavAction.logout, child: Text('Log out'))
                ];
              },
            )
          ],
        ),
        body: GestureDetector(
          child: const features.BottomNavigation(),
          onTap: () {
            FocusScope.of(context).unfocus();
          },
        ));
  }
}
