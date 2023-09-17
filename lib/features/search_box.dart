import 'package:flutter/material.dart';

import 'searchfield_form_button.dart';
import '../forms/nr_persoane.dart';
import '../forms/search_data.dart';
import '../forms/searchfield_form.dart';

class SearchBox extends StatefulWidget {
  final String functionName;
  final String textLabel;
  final String icon;
  final Text? textAbove;
  const SearchBox({
    super.key,
    this.textAbove,
    required this.icon,
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
          //margin: const EdgeInsets.all(10),
          width: 400,
          decoration: BoxDecoration(
            boxShadow: const [
              // BoxShadow(
              //   color: Pallete.colorDim3,
              //   blurRadius: 5,
              //   offset: Offset(0, 0),
              // )
            ],
            //color: const Color.fromARGB(255, 208, 255, 255),
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(
            //   color: Pallete.colorDim3,
            //   width: 2,
            // )
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: widget.textAbove,
              ),

              const SizedBox(
                height: 5,
              ),
              //start location form
              searchfieldForm(_startLocation, _formKey1, 'pornire', Icons.home),
              const SizedBox(
                height: 10,
              ),

              //final location form
              searchfieldForm(
                  _endLocation, _formKey2, 'destinația', Icons.location_pin),
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
            ],
          ),
        ),
      ),
    );
  }
}
