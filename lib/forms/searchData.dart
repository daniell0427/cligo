import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class searchData extends StatefulWidget {
  const searchData({super.key});

  @override
  State<searchData> createState() => _searchDataState();
}

class _searchDataState extends State<searchData> {
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
        style: TextStyle(fontSize: 25, color: Pallete.textColor),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today_rounded),
          prefixIconColor: Colors.white,
          hintText: 'aa-ll-zz',
          hintStyle: TextStyle(color: Colors.white38),
          labelText: 'data',
          labelStyle: TextStyle(color: Colors.white),
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
            firstDate: DateTime(2022),
            lastDate: DateTime(2026),
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
