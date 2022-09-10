import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/layout/shop_layout/layout.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
class LayoutCubit extends Cubit<ShopHomeStates>{
  LayoutCubit() : super( InitialBottomNavState());

  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> items=[
  BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home',),
  BottomNavigationBarItem(icon: Icon(Icons.category_outlined,), label: 'Categories',),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded,), label: 'Favorite',),
    BottomNavigationBarItem(icon: Icon(Icons.settings,), label: 'Settings',)
  ];

  List<Widget> screens=[HomeScreen(),categoriesScreen()
    , favoriteScreen(),settingsScreen(),];

  Widget open=HomeScreen();

  void changeNavBar(int index){
    currentIndex=index;
    //open=screens[currentIndex];
    emit(ChangeBottomNavState());
  }
  HomeModel? homeM;
  void getHomeData(){
    emit(ShopHomeLoadingState());
    print('from get home');
     DioHelper.getData(
        path: 'home',
        token: istoken
       ).then((value) {

         homeM!=HomeModel.fromjson(value.data);
         print(homeM!.data!.productList[0].image);
         print('from success');
         emit(ShopHomeSuccessState());
    }).catchError((error){
      emit(ShopHomeErrorState(error));
      print (error.toString());
    });
  }
   CategoriesModel? catModel;
  Future <void> getCtegories()async{
    emit(ShopCategoriesLoadingState());
   await DioHelper.getData(
        path: 'categories',
        token: istoken
    ).then((value) {

      catModel!=CategoriesModel.fromJson(value.data);
      print(catModel!.dataModel!.currentPage);
      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      emit(ShopCategoriesErrorState(error));
      print (error.toString());
    });
  }



}