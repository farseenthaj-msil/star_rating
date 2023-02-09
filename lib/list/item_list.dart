import 'package:flutter/material.dart';

class ItemList extends ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => _items;

  void addItem(double value) {
    _items.add(value.toString());
    notifyListeners();
  }

  int getCount() {
      int count = int.parse(double.parse(items.last).toStringAsFixed(0));
      count < double.parse(items.last) ? count = count + 1  : count ;

      return count;
    }

}