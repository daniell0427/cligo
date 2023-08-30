import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cligo/newWidgets/calatorie_item.dart';

import '../newWidgets/search_box.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallete.colorDim0,
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBox(),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: FittedBox(
                  child: Column(
                    children: [
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                      calatorieItem(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
