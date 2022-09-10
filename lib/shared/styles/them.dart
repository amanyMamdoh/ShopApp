import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';


var lightTheme= ThemeData(
primarySwatch:  baseColor,
scaffoldBackgroundColor: Colors.white,
appBarTheme: AppBarTheme(
// backwardsCompatibility: false,
elevation: 1,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarIconBrightness: Brightness.dark

),
iconTheme: IconThemeData(
color: Colors.black
),
titleTextStyle: TextStyle(
color: Colors.black,
fontSize: 20,
fontWeight: FontWeight.bold
),
backgroundColor: Colors.white,
//
/*  */
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
selectedItemColor: baseColor2,
backgroundColor: baseColor,

),
textTheme: TextTheme(
bodyText1: TextStyle(
fontSize:18,
fontWeight: FontWeight.w300,
color: Colors.black

)

)
//  bottomNavigationBarTheme:const  Bottom
);
var darkTheme=ThemeData(
primarySwatch:baseColor,
//scaffoldBackgroundColor: Colors.white,
appBarTheme: AppBarTheme(
// backwardsCompatibility: false,
elevation: 1,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.black,
statusBarIconBrightness: Brightness.light

),
iconTheme: IconThemeData(
color: Colors.white
),
titleTextStyle: TextStyle(
color: Colors.white,
fontSize: 20,
fontWeight: FontWeight.bold
),
backgroundColor:HexColor("606060"),
//
/*  */
),
scaffoldBackgroundColor: HexColor('606060'),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
selectedItemColor: Colors.grey,
backgroundColor: baseColor,
selectedIconTheme: IconThemeData(
color:Colors.grey,
size: 24,
),


//activeColor:Colors.grey
),
textTheme: TextTheme(
bodyText1: TextStyle(
fontSize:18,
fontWeight: FontWeight.w300,
color: Colors.white

)

)
//  bottomNavigationBarTheme:const  Bottom


);
