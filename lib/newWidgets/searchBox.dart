import 'package:flutter/material.dart';

import '../forms/searchfield_form.dart';

class searchBox extends StatefulWidget {
  searchBox({super.key});

  @override
  State<searchBox> createState() => _searchBoxState();

  late final TextEditingController _startLocation;
  late final TextEditingController _endLocation;
  late final TextEditingController _dateinput;
  late final TextEditingController _availableSeats;

  @override
  void initState() {
    _startLocation = TextEditingController();
    _endLocation = TextEditingController();
    _dateinput = TextEditingController();
    _availableSeats = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _startLocation.dispose();
    _endLocation.dispose();
    _dateinput.dispose();
    _availableSeats.dispose();

    super.dispose();
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
}

class _searchBoxState extends State<searchBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
              color: const Color.fromARGB(127, 14, 54, 79),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white60,
                width: 2,
              )),
          padding: EdgeInsets.all(10),
          child: Column(children: [
            searchfieldForm(_startLocation, _formKey1, 'Locația'),
            const SizedBox(
              height: 10,
            ), // * for padding
            searchfieldForm(_endLocation, _formKey2, 'Destinația'),
            const SizedBox(
              height: 10,
            ), // * for padding
            Row(
              children: [
                Expanded(flex: 1, child: searchData()),
                const SizedBox(
                  width: 10,
                ), // * for padding
                Expanded(flex: 1, child: nrPersoane()),
              ],
            ),
            SizedBox(height: 10), // * for padding
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            )
          ]),
        ),
      ),
    );
  }
}
