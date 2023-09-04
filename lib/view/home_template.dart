import 'package:cligo/constants/colors.dart';
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
        toolbarHeight: 70,
        backgroundColor: Pallete.colorDim4,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(placeHolderLogo),
                backgroundColor: Colors.transparent,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, profileRoute);
                },
                icon: const Icon(
                  Icons.account_circle,
                  color: Pallete.colorDim0,
                ),
                iconSize: 50,
              )
            ],
          )
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
