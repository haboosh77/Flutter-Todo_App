

import 'package:flutter/material.dart';


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

})=>TextFormField(
  controller:controller ,
  keyboardType:type,
  obscureText: isPassword,
  onFieldSubmitted:Submitted ,
  //عندما اكتب واكبس الصح يلي على الكيبورد
  onChanged: onChanged,
  //بيطبع حرف حرف بس كل مره بطباعه رح يعطي من اول لحد ما كتبت
  //ه
  //هب
  //هبه
  validator:valdaitefun ,
  decoration: InputDecoration(
    hintText: hintText,
    labelText:  labelText,
    prefixIcon: Icon(prefix),
    suffixIcon:suffix !=null?IconButton(onPressed: suffixPress,
        icon:Icon( suffix)):null,


    border: OutlineInputBorder(),

  ),
);
