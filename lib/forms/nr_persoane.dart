import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NrPersoane extends StatefulWidget {
  TextEditingController seatsController;
  NrPersoane({super.key, required this.seatsController});

  @override
  State<NrPersoane> createState() => _NrPersoaneState();
}

class _NrPersoaneState extends State<NrPersoane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      // width: 100,
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
        controller: widget.seatsController,
        style: const TextStyle(fontSize: 25, color: Pallete.textColor),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Pallete.colorDim4,
            size: 30,
          ),
          labelText: 'locuri',
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
      ),
    );
  }
}
