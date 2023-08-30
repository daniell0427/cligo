import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';

import '../features/searchfield_form_button.dart';
import '../forms/nr_persoane.dart';
import '../forms/search_data.dart';
import '../forms/searchfield_form.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

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
              color: const Color.fromARGB(66, 136, 227, 227),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Pallete.colorDim3,
                width: 2,
              )),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Cauta ruta:',
                  style: TextStyle(fontSize: 25, color: Pallete.colorDim3),
                ),
              ),

              const SizedBox(
                height: 5,
              ),
              //start location form
              searchfieldForm(_startLocation, _formKey1, 'locația'),
              const SizedBox(
                height: 10,
              ),

              //end location form
              searchfieldForm(_endLocation, _formKey2, 'destinația'),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  //search data form
                  Expanded(flex: 1, child: SearchData()),
                  SizedBox(
                    width: 10,
                  ),

                  //numar persoane form
                  Expanded(flex: 1, child: NrPersoane()),
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
                textLabel: 'Caută',
                functionName: 'takeFromDatabase',
              )
              //end searchfield button
            ],
          ),
        ),
      ),
    );
  }
}
