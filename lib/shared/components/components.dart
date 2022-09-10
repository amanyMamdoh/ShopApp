import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/modules/login/login_screen.dart';
Widget buildTextField( {
  required TextEditingController controller,
  required TextInputType type,
  required IconData ic,
  required String label  ,
  IconData? suffix,
  VoidCallback? suffixPressd,
  final Function(String)? validate ,
  bool obsecure =false
})=>
    Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            color: Colors.grey.shade200
        ),
        width: double.infinity,
        height: 70,
        // color: Colors.black,
        child:  TextFormField(
            controller: controller,
            obscureText: obsecure,
            //onChanged: onChange,
            validator:(value){
              if(value!.isEmpty)
                return " empty input,you should enter data" ;
              else
                return null;
            },
            keyboardType: type,

            decoration:  InputDecoration    (
              suffixIcon: IconButton(icon: Icon(suffix),
                onPressed:suffixPressd ,
              ),

              labelText: label,
              prefixIcon:Icon(ic,color: baseColor2,),
              border: InputBorder.none,

            )
        )



    );
Widget buildButton({
  double width = double.infinity,
 double height=50.0,
  Color color =baseColor,
  required VoidCallback press,
  required String text,
   bool isUpperCase = true,

}){
  return Container(
    width: width,
    height:height ,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: color,
    ),
    child: MaterialButton(
      child: Text(isUpperCase? text.toUpperCase():text,
                style: TextStyle(
                  color: Colors.white
                ),),
      onPressed:press,

    ),
  );
}
Widget buildTextInkWell({
   context ,
  required String text,
  required  tap,
   Color color=baseColor,
  required double fontSize,
  bool isBoold=true
}){
  return InkWell(
  child: Padding(
  padding: EdgeInsets.all(10),
      child: Text(text,
        style:TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight:isBoold?FontWeight.bold:FontWeight.normal
       ),),
     ),
      onTap: tap,
);
}


