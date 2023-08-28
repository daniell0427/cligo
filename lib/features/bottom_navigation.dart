import 'package:cligo/view/add_view.dart';
import 'package:cligo/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cligo/constants/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  final screen = const [
    HomeView(),
    AddView(),
    Text('Chat'),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      const Icon(
        Icons.home,
        size: 45,
      ),
      const Icon(
        Icons.add_rounded,
        size: 50,
      ),
      const Icon(
        Icons.chat_rounded,
        size: 40,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: screen[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const  IconThemeData(color: Pallete.colorDim0),),
        child: CurvedNavigationBar(
          color: Pallete.colorDim4,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Pallete.colorDim4,
          height: 60.0,
          items: items,
          index: index,
          animationDuration: const  Duration(milliseconds: 200),
          onTap: (index) => setState(
            () => this.index = index,
          ),
        ),
      ),
    );
  }
}