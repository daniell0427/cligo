import 'package:cligo/constants/variables.dart';
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
        appBar: AppBar(title: const Text('Idk adi')),
        body: ListViewBuilder(
          emptyText: 'Din păcate nu am găsit nici o potivire!',
          ids: matchingRoutesIDs,
        ));
  }
}
