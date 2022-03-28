import 'package:flutter/material.dart';
import './view/home_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyShop',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.cyan,
          secondary: Colors.amberAccent,
        ),
      ),
      home: MyHomePage(),
    );
  }
}
