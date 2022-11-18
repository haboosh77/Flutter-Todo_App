

import 'package:flutter/material.dart';
import 'package:todo_app/moudels/archivetasks.dart';
import 'package:todo_app/moudels/donetasks.dart';
import 'package:todo_app/moudels/newtaskscreen.dart';

class HomeLayout extends StatefulWidget {

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int currentIndex=0;
 List<Widget> screens=[
   NewTaskeScreen(),
   DoneTaskeScreen(),
   ArchiveTaskeScreen(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

         currentIndex: currentIndex,
        onTap:(index){
           setState(() {
             currentIndex=index;
           });
        } ,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.menu),
          label: "Tasks",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.check_circle),
            label: "Done",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),
            label: "Archived",
          ),
        ],
      ) ,
    );
  }
}
