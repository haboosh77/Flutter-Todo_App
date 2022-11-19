

import 'package:flutter/material.dart';

class DoneTaskeScreen extends StatelessWidget {
  const DoneTaskeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Done Tasks',style:TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold
    ));
  }
}
