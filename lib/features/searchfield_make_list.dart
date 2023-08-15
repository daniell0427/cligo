import 'package:searchfield/searchfield.dart';

makeSearchFieldList(value) {
  List<SearchFieldListItem> sfListItems = [];
  for (var item in value) {
    sfListItems.add(SearchFieldListItem(item));
  }
  return sfListItems;
}
