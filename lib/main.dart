import 'package:flutter/material.dart';
import 'package:todo_app/layout/homelayout.dart';

void main() {
  runApp(myApp());

}


   class myApp  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false ,
      home: HomeLayout(),
    );
  }
}
