import 'package:flutter/material.dart';
import 'package:star_rating/list/item_list.dart';
import 'package:provider/provider.dart';

import './screen/rating_screen.dart';
import './list/item_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemList>(
      create: (BuildContext context) =>  ItemList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Star Rating App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RatingScreen(),
      ),
    );
  }
}
