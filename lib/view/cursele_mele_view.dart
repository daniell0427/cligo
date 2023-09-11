import 'package:cligo/features/calatorie_item.dart';
import 'package:flutter/material.dart';

class CurseleMeleView extends StatefulWidget {
  const CurseleMeleView({super.key});

  @override
  State<CurseleMeleView> createState() => _CurseleMeleViewState();
}

class _CurseleMeleViewState extends State<CurseleMeleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursele Mele'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.transparent,
        // child: const CalatorieItem(
        //   date: '12',
        //   destination: 'Nisporeni',
        //   location: 'Chisinau',
        //   pfp: 'widget.pfp',
        //   seats: 2,
        //   userName: 'Danu',
        // ),
      ),
    );
  }
}
