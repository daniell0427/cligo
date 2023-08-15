import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../constants/list_of_countries_and_cities.dart' as mylist;
import '../features/searchfield_make_list.dart';

final _formKey = GlobalKey<FormState>();

final homeView = Padding(
  padding: const EdgeInsets.all(5.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Form(
        key: _formKey,
        child: SizedBox(
          width: 150,
          height: 40,
          child: SearchField(
            suggestions: makeSearchFieldList(mylist.countries),
            validator: (x) {
              if (!mylist.countries.contains(x) || x!.isEmpty) {
                return 'Please Enter a valid State';
              }
              return null;
            },
            maxSuggestionsInViewPort: 6,
            suggestionState: Suggestion.expand,
            searchInputDecoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(122, 57, 57, 57),
              hintText: 'Caută..',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: BorderSide.strokeAlignOutside,
              ),
              labelText: 'Countries',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print('alright');
          }
        },
        child: const Text('Submit'),
      )
    ],
  ),
);
