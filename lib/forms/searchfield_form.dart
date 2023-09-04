import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../constants/list_of_countries_and_cities.dart' as mylist;
import '../features/my_functions.dart';
import 'package:cligo/constants/colors.dart';

searchfieldForm(controllerValue, formkey, myLabelText) {
  return Form(
      key: formkey,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [Colors.white54, Colors.white10],
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          // ),
          color: Pallete.colorDim0,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SearchField(
          controller: controllerValue,
          searchStyle: const TextStyle(color: Pallete.textColor, fontSize: 25),
          suggestions: makeSearchFieldList(mylist.cities),
          suggestionStyle: const TextStyle(
            color: Pallete.colorDim4,
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
            prefixIconColor: Pallete.colorDim4,
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Caută...',
            hintStyle: const TextStyle(
              color: Pallete.colorGray,
              fontSize: 20,
              height: BorderSide.strokeAlignOutside,
            ),
            labelText: myLabelText,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 25,
                color: Pallete.colorDim4),
            //*border
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.colorDim4,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.colorDim4,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.colorDim4,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Pallete.colorDim4,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ));
}
