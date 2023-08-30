import 'package:flutter/material.dart';
import 'package:cligo/features/calatorie_item.dart';

import '../features/search_box.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 185, 201),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //searchbox
              SearchBox(textLabel: 'Caută', functionName: 'takeFromDatabase'),

              //calatorie Items
              Padding(
                padding: EdgeInsets.all(15.0),
                child: FittedBox(
                  child: Column(
                    children: [
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
                      CalatorieItem(),
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
