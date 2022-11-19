import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/homelayout.dart';
import 'package:todo_app/shared/block_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

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
