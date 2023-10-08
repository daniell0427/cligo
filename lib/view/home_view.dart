import 'package:cligo/constants/colors.dart';
import 'package:cligo/database/services/route_service.dart';
import 'package:flutter/material.dart';
import '../features/search_box.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    const dynamic textAbove = Text(
      'Cauta ruta:',
      style: TextStyle(fontSize: 25, color: Pallete.colorDim3),
    );

    return Scaffold(
      backgroundColor: Pallete.colorDim0,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  //searchbox
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: Pallete.colorDim3,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 0),
                      //   )
                      // ],
                      color: const Color.fromARGB(255, 208, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: Pallete.colorDim3,
                      //   width: 2,
                      // )
                    ),
                    child: const SearchBox(
                      textLabel: 'Caută',
                      functionName: 'takeFromDatabase',
                      textAbove: textAbove,
                      icon: 'Icons.home',
                    ),
                  ),

                  //calatorie Items
                  Expanded(child: RouteService().getRecentIDs()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
