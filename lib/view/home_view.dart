import 'package:cligo/view/login_view.dart';
import 'package:cligo/view/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('UI'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile/');
              },
              icon: const Icon(Icons.person)),
          PopupMenuButton<NavAction>(
            icon: const Icon(Icons.settings),
            onSelected: (value) async {
              switch (value) {
                case NavAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
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
      body: const Text('Hi there'),
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Logout')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
