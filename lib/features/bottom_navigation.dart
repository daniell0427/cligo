import 'package:cligo/features/searchfield_make_list.dart';
import 'package:cligo/view/home_template.dart';
import 'package:cligo/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../constants/list_of_countries_and_cities.dart' as mylist;

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late final TextEditingController _country;

  @override
  void initState() {
    _country = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _country.dispose();
    super.dispose();
  }

  final pages = [
    homeView,
    const Text('Add'),
    const Text('Chat'),
  ];

  int _curentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        iconSize: 40,
        currentIndex: _curentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: String.fromEnvironment('Home'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: String.fromEnvironment('Add'),
            backgroundColor: Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: String.fromEnvironment('Chat'),
            backgroundColor: Colors.grey,
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _curentIndex = index;
            },
          );
        },
      ),
    );
  }
}
