import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../constants/list_of_countries_and_cities.dart' as mylist;
import '../features/my_functions.dart';
import 'package:cligo/constants/colors.dart';

searchfieldForm(controllerValue, formkey, myLabelText) {
  return Form(
    key: formkey,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white54, Colors.white10],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SearchField(
        controller: controllerValue,
        searchStyle: const TextStyle(color: Pallete.textColor, fontSize: 25),
        suggestions: makeSearchFieldList(mylist.cities),
        suggestionStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        itemHeight: 50,
        //validates the suggestion
        validator: (x) {
          if (!mylist.cities.values.elementAt(0).contains(x) &&
                  !mylist.cities.values.elementAt(1).contains(x) ||
              x!.isEmpty) {
            return 'Introduceți o locație valabilă!';
          }
          return null;
        },
        maxSuggestionsInViewPort: 5,
        searchInputDecoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_pin),
          prefixIconColor: Colors.white,
          filled: true,
          fillColor: Colors.transparent,
          hintText: 'Caută...',
          hintStyle: const TextStyle(
            color: Colors.white38,
            fontSize: 20,
            height: BorderSide.strokeAlignOutside,
          ),
          labelText: myLabelText,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    ),
  );
}
