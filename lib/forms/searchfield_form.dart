import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../constants/list_of_countries_and_cities.dart' as mylist;
import '../features/my_functions.dart';

searchfieldForm(controllerValue, formkey, myLabelText) {
  return Form(
    key: formkey,
    child: SizedBox(
      width: 180,
      height: 50,
      child: SearchField(
        controller: controllerValue,
        searchStyle: const TextStyle(color: Colors.white),
        suggestions: makeSearchFieldList(mylist.cities),
        suggestionStyle: const TextStyle(),
        validator: (x) {
          if (!mylist.cities.values.elementAt(0).contains(x) ||
              mylist.cities.values.elementAt(1).contains(x) ||
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
          fillColor: const Color.fromARGB(122, 57, 57, 57),
          hintText: 'Caută..',
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: BorderSide.strokeAlignOutside,
          ),
          labelText: myLabelText,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
        ),
      ),
    ),
  );
}

searchfieldButton(formKey1, formKey2) {
  return SizedBox(
    width: 150,
    child: ElevatedButton(
      onPressed: () {
        if (formKey1.currentState!.validate()) {}
        if (formKey2.currentState!.validate()) {}
      },
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ),
  );
}
