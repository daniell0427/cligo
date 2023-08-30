import 'package:flutter/material.dart';

import 'searchfield_form_button.dart';
import '../forms/nr_persoane.dart';
import '../forms/search_data.dart';
import '../forms/searchfield_form.dart';

class SearchBox extends StatefulWidget {
  final String functionName;
  final String textLabel;
  const SearchBox({
    super.key,
    required this.functionName,
    required this.textLabel,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //start location form
              searchfieldForm(_startLocation, _formKey1, 'Locația'),
              const SizedBox(
                height: 10,
              ),

              //end location form
              searchfieldForm(_endLocation, _formKey2, 'Destinația'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  //search date form
                  Expanded(
                      flex: 1,
                      child: SearchData(
                        date: _dateinput,
                      )),
                  const SizedBox(
                    width: 10,
                  ),

                  //numar persoane form
                  Expanded(
                    flex: 1,
                    child: NrPersoane(
                      seatsController: _availableSeats,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              //searchfield button
              SearchfieldButton(
                formKey1: _formKey1,
                formKey2: _formKey2,
                locationController: _startLocation,
                destinationController: _endLocation,
                dateController: _dateinput,
                seatsController: _availableSeats,
                textLabel: widget.textLabel,
                functionName: widget.functionName,
              )
              //end searchfield button
            ],
          ),
        ),
      ),
    );
  }
}