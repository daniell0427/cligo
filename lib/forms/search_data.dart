import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchData extends StatefulWidget {
  final TextEditingController date;
  const SearchData({super.key, required this.date});

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  DateTime dateTime = DateTime(2022, 12, 25);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      //width: 100,
      decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   colors: [Colors.white54, Colors.white10],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        // ),
        color: Pallete.colorDim0,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: widget.date,
        readOnly: false,
        style: const TextStyle(
          fontSize: 25,
          color: Pallete.textColor,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today_rounded),
          prefixIconColor: Pallete.colorDim4,
          labelText: 'data',
          labelStyle: const TextStyle(color: Pallete.colorDim4),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Pallete.colorDim4,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Pallete.colorDim4,
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
              widget.date.text = DateFormat('dd-MM-yy').format(pickeddate);
            });
          }
        },
      ),
    );
  }
}
