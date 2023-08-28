
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

makeSearchFieldList(Map whateverMap) {
  List listCities = whateverMap.values.toList();
  List<SearchFieldListItem> sfListItems = [];
  for (var cities in listCities) {
    for (var city in cities) {
      String country = whateverMap.keys
          .firstWhere((element) => whateverMap[element] == cities);
      sfListItems.add(SearchFieldListItem(
        city,
        child: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: city,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: '\n$country',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
              style: const TextStyle(
                color: Colors.black,
              )),
        ),
      ));
    }
  }
  return sfListItems;
}
