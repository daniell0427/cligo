import 'package:cligo/view/add_view.dart';
import 'package:cligo/view/chat_list_view.dart';
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
    ChatListView(),
  ];

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: index);
  }

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
      body: PageView(
        controller: pageController,
        children: screen,
        onPageChanged: (pageIndex) {
          setState(() {
            index = pageIndex;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(
              color: Pallete.colorDim0), // Customize your icon color here
        ),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Pallete.colorDim4,
                blurRadius: 60,
                offset: Offset(0, 20),
              )
            ],
          ),
          child: CurvedNavigationBar(
            color:
                Pallete.colorDim4, // Customize your navigation bar color here
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Pallete
                .colorDim4, // Customize your button background color here
            height: 60.0,
            items: items,
            index: index,
            animationDuration: const Duration(milliseconds: 200),
            onTap: (pageIndex) {
              pageController.animateToPage(
                pageIndex,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
