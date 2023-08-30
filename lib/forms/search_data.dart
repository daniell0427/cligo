import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchData extends StatefulWidget {
  const SearchData({super.key});

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  DateTime dateTime = DateTime(2022, 12, 25);
  final TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white54, Colors.white10],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: _date,
        readOnly: true,
        style: const TextStyle(
          fontSize: 25,
          color: Pallete.textColor,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today_rounded),
          prefixIconColor: Colors.white,
          labelText: 'Data',
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white60,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white60,
              width: 2,
            ),
          ),
        ),
        onTap: () async {
          DateTime? pickeddate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (pickeddate != null) {
            setState(() {
              _date.text = DateFormat('dd-MM-yy').format(pickeddate);
            });
          }
        },
      ),
    );
  }
}
