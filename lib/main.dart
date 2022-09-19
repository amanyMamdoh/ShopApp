

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocObserver.dart';
import 'package:shop_app/layout/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/layout.dart';
import 'package:shop_app/modules/login/cubit/state.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/them.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isBoarding;
    isBoarding=CacheHelper.getBooleanData(key: 'onBoarding');
   istoken=CacheHelper.getStringData(key: 'token');
  // Widget? widget;
  print(isBoarding);
  print(istoken);
  if(isBoarding==null)
     runApp( MyApp(OnBoardingScreen()));
  if(isBoarding==true ) {
    if (istoken == null)
      runApp(MyApp(LoginScreen()));
    else
      runApp(MyApp(ShopLayout()));
  }




}

class MyApp extends StatelessWidget {
  Widget? start;
  MyApp(this.start);
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LayoutCubit()..getHomeData()
                                                    ..getCtegories()
                                                    ..getFavorite()
                                                     ..getUser(),
      child:  MaterialApp(
        theme: lightTheme,
        home:start,
    )
    );
  }

}

