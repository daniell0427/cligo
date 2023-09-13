import 'package:cligo/constants/colors.dart';
import 'package:cligo/constants/variables.dart';
import 'package:flutter/material.dart';
import '../features/list_view_builder.dart';

class MyRoutesView extends StatefulWidget {
  const MyRoutesView({super.key});

  @override
  State<MyRoutesView> createState() => _MyRoutesViewState();
}

class _MyRoutesViewState extends State<MyRoutesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cursele mele',
          style: TextStyle(color: Pallete.colorDim0),
        ),
        centerTitle: true,
        backgroundColor: Pallete.colorDim4,
      ),
      body: Container(
        color: Pallete.colorDim0,
        child: myRouteIDs.isEmpty
            ? Center(
                child: FittedBox(
                  child: Container(
                    color: Pallete.colorDim0,
                    //width: 300,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 280,
                          child: Text(
                            'Nu ai nici o cursă activă la moment!',
                            style: TextStyle(
                              fontSize: 24, // Adjust the font size as needed
                              color: Colors
                                  .black, // You can change the text color here
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ListViewBuilder(
                  emptyText: '',
                  ids: myRouteIDs,
                ),
              ),
      ),
    );
  }
}
