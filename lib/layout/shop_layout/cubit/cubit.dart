import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/layout/shop_layout/layout.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/favorites_model/favorite_items_model.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
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
 Map<int? , bool?> favorite={};
  void getHomeData(){
    emit(ShopHomeLoadingState());
    print('from get home');
     DioHelper.getData(
        path: 'home',
        token: istoken!
       ).then((value) {

         homeM=HomeModel.fromjson(value.data);
         print(homeM!.data!.productList[0].image);
         homeM!.data!.productList.forEach((element) {
           favorite.addAll({element.id:element.inFavorites});
         });
         print(favorite);
         emit(ShopHomeSuccessState());
    }).catchError((error){
      emit(ShopHomeErrorState(error));
      print (error.toString());
    });
  }


  CategoriesModel? catModel;
  void getCtegories(){
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
        path: 'categories',
        token: istoken!
    ).then((value) {

      catModel=CategoriesModel.fromJson(value.data);
      print(catModel!.dataModel!.currentPage);
      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      emit(ShopCategoriesErrorState(error));
      print (error.toString());
    });
  }
  FavoriteModel? favModel;
  bool isFav=false;
  void changeFavorite(int productId){
    if(favorite[productId]==true){
      favorite[productId]=false;
      emit(ChangeFavoriteModelState());
    }else{
      favorite[productId]=true;
      emit(ChangeFavoriteModelState());
    }

  emit(ChangeFavoriteModelLoadingState());
    DioHelper.postData(url: favorites,
        data: {
         'product_id':productId
        },
    token: istoken!
    ).
    then((value) {
      favModel=FavoriteModel.fromJson(value.data);
      print(favModel!.message);
      print(favModel!.status);
      if(favModel!.status ==false){
       // favorites![id] = !favorites![id]!;

        favorite![productId] = ! favorite![productId!]!;
      /*  if(favorite[productId]==true){
          favorite[productId]!=false;
        }else{
          favorite[productId]!=true;
        }*/
      }else{
        getFavorite();
      }
      emit(ChangeFavoriteModelSuccessState());
    }).catchError((error){
      if(favorite[productId]==true){
        favorite[productId]!=false;
      }else{
        favorite[productId]!=true;
      }
      emit(ChangeFavoriteModelErrorState(error));
    });
  }

 FavoriteItemsModel? favItemModel;
  void getFavorite(){
    emit(GetFavoriteLoadingState());
    DioHelper.getData(
        path: 'favorites',
      token: istoken!
    ).then((value){
      favItemModel=FavoriteItemsModel.fromJson(value.data);
      print(favItemModel);
      emit(GetFavoriteSuccessState());
    }).catchError((error){
      emit(GetFavoriteErrorState(error));
    });
  }

  ShopLoginModel? userModel;
void getUser() {
emit(GetUserLoadingState());
  DioHelper.getData(
      path: profile,
      token:istoken!
  ).then((value){
    userModel=ShopLoginModel.fromJson(value.data);
    print(userModel!.data!.name);
    emit(GetUserSuccessState());
  }).catchError((error){
    emit(GetUserErrorState(error));
  });
}
  void updateUserData({
    required String name,
    required String email,
    required String phone,

  }){
    emit(UpdateUserLoadingState());
    print('from get home');
    DioHelper.putData(
        url: updateUser,
        token: istoken!,
        data: {
          'name':name,
          'email':email,
          'phone':phone,

        }
    ).then((value) {

      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.phone);
      emit(UpdateUserSuccessState());
    }).catchError((error){
      emit(UpdateUserErrorState(error));
      print (error.toString());
    });
  }

}