import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cligo/database/functions/route_service.dart';
import '../features/search_box.dart';

class EditSearchView extends StatefulWidget {
  const EditSearchView({super.key});

  @override
  State<EditSearchView> createState() => _EditSearchViewState();
}

class _EditSearchViewState extends State<EditSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editează',
          style: TextStyle(color: Pallete.colorDim4, fontSize: 25),
        ),
        iconTheme: const IconThemeData(color: Pallete.colorDim4, size: 30),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Pallete.colorDim0,
      ),
      body: Container(
        color: Pallete.colorDim0,
        child: const Column(
            children: [SearchBox(functionName: 'null', textLabel: 'Schimbă')]),
      ),
    );
  }
}
