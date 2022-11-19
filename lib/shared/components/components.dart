

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'cubit/cubit.dart';


Widget defaultButton({
  double? width=double.infinity,//common use
   Color? background=Colors.blue,
  bool? isuUpperCase=true,
  required Function() function,
  required String text,
  double? radius=10.0,
})=>Container(
    width: width,

    decoration: BoxDecoration(borderRadius:BorderRadius.circular(radius!) ,
      color: background,
    ),
    child:
    MaterialButton(
      onPressed:function ,

      child: Text(
        isuUpperCase!?text.toUpperCase():text,
        style: TextStyle(color: Colors.white),),));



Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
    bool?  obscureText,
  Function(String)? Submitted,
  Function(String?)? onChanged,
  required FormFieldValidator  valdaitefun,
  bool isPassword=false,
  String? labelText,
  String? hintText,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPress,
  Function()? onTap,
 bool? isClickable=true,
})=>TextFormField(
  controller:controller ,
  keyboardType:type,
  enabled:isClickable ,
  obscureText: isPassword,
  onFieldSubmitted:Submitted ,
  //عندما اكتب واكبس الصح يلي على الكيبورد
  onChanged: onChanged,
  //بيطبع حرف حرف بس كل مره بطباعه رح يعطي من اول لحد ما كتبت
  //ه
  //هب
  //هبه
  validator:valdaitefun ,
  onTap: onTap,
  decoration: InputDecoration(
    hintText: hintText,
    labelText:  labelText,
    prefixIcon: Icon(prefix),
    suffixIcon:suffix !=null?IconButton(onPressed: suffixPress,
        icon:Icon( suffix)):null,


    border: OutlineInputBorder(),

  ),
);

Widget tasksBuilder(List<Map> tasks) => ConditionalBuilder(
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    ),
    itemCount: tasks.length,
  ),
  condition: tasks.length > 0,
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        )
      ],
    ),
  ),
);
Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'archive', id: model['id']);
          },
          icon: Icon(Icons.archive),
          color: Colors.black45,
        ),
      ],
    ),
  ),
);