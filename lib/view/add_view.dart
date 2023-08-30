import 'package:cligo/features/search_box.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
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

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 5.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //searchbox
          SearchBox(textLabel: 'Adaugă', functionName: 'pushToDatabase'),
        ],
      ),
    );
  }
}
