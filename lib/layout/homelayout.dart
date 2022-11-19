

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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
 List<String> titles=[
 'New Task',
   'Done Task',
   'ArchiveTaske'
 ];
 @override
  void initState() {
   createDatabase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title:Text( titles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          //example of try

          // try{
          //   var name=await getName();
          //   print(name);
          //   throw('some error !!!!');
          //
          // }catch(err){
          //   throw('some error !!!!');
          //   print('error${err.toString()}');
          // }
          //another example to handel the error
          getName().then((value) {
            print(value);
            print ('osama');
            throw('انا عملت إيرور!!!!!!');
          }).catchError((err){
            print('error${err.toString()}');
          });

        },
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
  //Instance of 'Future<String>
  Future<String> getName()async{
    return 'Ahmed Ali';
  }

  void createDatabase()async{
   var database=await openDatabase(
     'todo.db',
     version: 1,
     onCreate: (database,version){
       //id integer
       //title String
       //date String
       //time String
       //status String
       print('database created');
        database.execute(
          'CREATE TABLE  tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT) '
        ).then((value) {
          print('table created');
        }).catchError((error){
          print("error when catch table ${error.toString()}");
        });
     },
     onOpen: (database){

       print('database opened');
     }
   );
  }

    void InsetToDatabase(){}

}
