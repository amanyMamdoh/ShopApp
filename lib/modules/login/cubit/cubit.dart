import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model/login.dart';
import 'package:shop_app/modules/login/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginLoadingState());

  static ShopLoginCubit get(Context)=>BlocProvider.of(Context);

  bool ispassword=true;
  IconData changeVisiblity=Icons.visibility;
 late ShopLoginModel loginModel;
  void changeSuffix(){
    ispassword=! ispassword;
    if(ispassword==false)
     changeVisiblity=Icons.visibility_off;
    else
      changeVisiblity=Icons.visibility;
  emit(ChangePasswordVisibility());

  }
  void userLogin({
  required String email,
    required String password
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: login,
        data: {
          'email':email,
          'password':password
        }).then((value){
          //print(value.data);
          loginModel=ShopLoginModel.fromJson(value.data);
         // print(loginModel.data);
          //print(loginModel.message);
          //print(loginModel.status);
          emit(ShopLoginSuccessfulState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  bool board=false;
  void setBoard({bool? fromShared}){
    if(fromShared !=null){
      board=fromShared;

    }else{
      board=! board;
      CacheHelper.saveData(key: 'onBoarding', value: board);

    }

  }
}