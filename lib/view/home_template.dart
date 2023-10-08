import 'package:cligo/constants/colors.dart';
import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/routes.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/features/bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    //get variables
    variables();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Pallete.colorDim4,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(20),
        //       bottomRight: Radius.circular(20),
        //     ),
        //   ),
        // ),
        leadingWidth: 150,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Flexible(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(placeHolderLogo),
                  backgroundColor: Colors.transparent,
                ),
              ),
               Flexible(
                child: Text(
                  'Cligo',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
        ),
        actions: [
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
