import 'package:cligo/constants/colors.dart';
import 'package:cligo/database/functions/route_service.dart';
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
                  const SearchBox(
                    textLabel: 'Caută',
                    functionName: 'takeFromDatabase',
                    textAbove: textAbove,
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
