import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/routes.dart';
import 'package:cligo/features/bottom_navigation.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'dart:developer' as devtools show log;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 185, 201),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, profileRoute);
            },
            icon: Image.asset(defaultAvatar),
          ),
        ],
      ),
      body: GestureDetector(
        //bottom navigation bar
        child: const BottomNavigation(),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
