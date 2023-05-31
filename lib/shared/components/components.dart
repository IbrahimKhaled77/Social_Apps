import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFromFiled({
  required Widget label,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required Function? validator,
   IconData? prefixIcon,
   IconData? suffixIcon,
  Function? suffix,
  Function? onTap,
  Function? onFieldSubmitted,
  Function? onChanged,
  bool password=false,

})=>TextFormField(
  controller: controller,
  validator: (String? value)=>validator!(value),
  keyboardType:keyboardType ,
  obscureText: password ? true :false ,
  onChanged: (String? value){
    try{
      onChanged!(value) ;
    }catch(e){
      if (kDebugMode) {
        print(null);
      }
    }

  },
  onTap: (){
    try{
      onTap!() ;
    }catch(e){
      if (kDebugMode) {
        print(null);
      }
    }

  },
  onFieldSubmitted: (String? value){
    try{
      onFieldSubmitted!(value) ;
    }catch(e){
      if (kDebugMode) {
        print(null);
      }
    }

  },
    decoration: InputDecoration(
    label:label ,
    border: const UnderlineInputBorder(),
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    suffixIcon: suffixIcon != null?IconButton(onPressed:()=> suffix!(), icon: Icon(suffixIcon)) : null,

  ),
);

Widget defaultButton({
  required Function function,
  required String text,
   bool? upperCase=false ,
})=>Container(
 height: 44.0,
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.teal.shade400,
    borderRadius: BorderRadius.circular(20.0),
  ),

  child:   MaterialButton(

  elevation: 10.0,
  onPressed:()=>function(),
  child: Text( upperCase! ?text.toUpperCase() : text,style: const TextStyle(color: Colors.white),),

  ),
);

Widget defaultElevatedButton({
  required Function function,
  required String text,
  bool? upperCase=false ,
})=>Container(
  width: double.infinity,
  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(20.0),
  ),
  child:   ElevatedButton(
    onPressed:()=>function(),
    child: Text( upperCase! ?text.toUpperCase() : text),

  ),
);





Widget defaultTextButton({
  required Function function,
  required String  text,
})=>TextButton(onPressed:()=> function(), child: Text(text));

void defaultNavigator(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

//toast

enum ToastState{success,error}

Future<bool?> showToast ({
  required String text,
  required ToastState state,
}) async =>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(states: state),
    textColor: Colors.white,
    fontSize: 16.0
);
Color toastColor({
  required ToastState states,
}){
  Color color;

  switch(states){

    case ToastState.success:
      color=Colors.green;
      break;
    case ToastState.error:
      color=Colors.red;
      break;

  }


  return color;

}


void defaultNav(context,widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
