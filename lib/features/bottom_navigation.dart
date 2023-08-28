import 'package:cligo/view/add_view.dart';
import 'package:cligo/view/home_view.dart';
import 'package:flutter/cupertino.dart';
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
            .copyWith(iconTheme: IconThemeData(color: Pallete.colorDim0)),
        child: CurvedNavigationBar(
          color: Pallete.colorDim4,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Pallete.colorDim4,
          height: 60.0,
          items: items,
          index: index,
          animationDuration: Duration(milliseconds: 200),
          onTap: (index) => setState(
            () => this.index = index,
          ),
        ),
      ),
    );
  }

  // final pages = [
  //   const HomeView(),
  //   const AddView(),
  //   const Text('Chat'),
  // ];

  // int _curentIndex = 0;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     body: pages[_curentIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       type: BottomNavigationBarType.shifting,
  //       iconSize: 40,
  //       currentIndex: _curentIndex,
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home),
  //           label: String.fromEnvironment('Home'),
  //           backgroundColor: Colors.blue,
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.add),
  //           label: String.fromEnvironment('Add'),
  //           backgroundColor: Colors.cyan,
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.chat),
  //           label: String.fromEnvironment('Chat'),
  //           backgroundColor: Colors.grey,
  //         ),
  //       ],
  //       onTap: (index) {
  //         setState(
  //           () {
  //             _curentIndex = index;
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
