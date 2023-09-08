import 'package:cligo/constants/colors.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/view/edit_search_view.dart';
import 'package:flutter/material.dart';
import '../features/list_view_builder.dart';

class RouteSearchView extends StatefulWidget {
  const RouteSearchView({super.key});

  @override
  State<RouteSearchView> createState() => _RouteSearchViewState();
}

class _RouteSearchViewState extends State<RouteSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Anenii Noi - Basarabeasca',
            style: TextStyle(color: Pallete.colorDim0),
          ),
          centerTitle: true,
          backgroundColor: Pallete.colorDim4,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditSearchView()));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Pallete.colorDim0,
                  size: 20,
                ))
          ],
        ),
        body: Container(
          color: Pallete.colorDim0,
          child: matchingRoutesIDs.isEmpty
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
                              'Din păcate nu am găsit nici o potivire!',
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
                    ids: matchingRoutesIDs,
                  ),
                ),
        ));
  }
}
