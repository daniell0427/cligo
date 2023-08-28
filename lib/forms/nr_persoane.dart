import 'package:cligo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NrPersoane extends StatefulWidget {
  const NrPersoane({super.key});

  @override
  State<NrPersoane> createState() => _NrPersoaneState();
}

class _NrPersoaneState extends State<NrPersoane> {
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
        style: const TextStyle(fontSize: 25, color: Pallete.textColor),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
          labelText: 'locuri',
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
      ),
    );
  }
}
