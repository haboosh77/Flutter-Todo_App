

import 'package:flutter/material.dart';

class NewTaskeScreen extends StatelessWidget {
  const NewTaskeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('New Tasks',style:TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold
    ));
  }
}
