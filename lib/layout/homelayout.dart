
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/components/components.dart';

import '../shared/components/cubit/cubit.dart';
import '../shared/components/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  // Variables
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titleScreen[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppCreateDatabaseLoadingState,
              builder: (context) => cubit.bodyScreens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShawn) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        date: dateController.text, time: timeController.text, title: titleController.text);
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextForm(
                              prefix: Icons.title,
                            valdaitefun: ( val) {
                                if (val!.isEmpty) {
                                  return 'title is empty';
                                }
                                return null;
                              },
                              controller: titleController,
                              labelText: 'Task Title',
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 15),
                            defaultTextForm(
                              prefix: Icons.watch_later_outlined,
                              valdaitefun: (val) {
                                if (val!.isEmpty) {
                                  return 'time is empty';
                                }
                                return null;
                              },

                              controller: timeController,
                              labelText: 'Task Time',
                              type: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                  timeController.text = value!.format(context).toString();
                                });
                              },
                            ),
                            SizedBox(height: 15),
                            defaultTextForm(
                              prefix: Icons.calendar_today,
                              valdaitefun: (val) {
                                if (val!.isEmpty) {
                                  return 'Date is empty';
                                }
                                return null;
                              },
                              controller: dateController,
                              labelText: 'Task Date',
                              type: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2023-12-12'))
                                    .then((value) {
                                  dateController.text = DateFormat.yMMMd().format(value!);
                                });
                              },
                            )],
                        ),
                      ),
                    ),
                    elevation: 20,
                  )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}