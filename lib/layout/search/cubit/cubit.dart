import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/search/cubit/state.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<ShopHomeSearchState>{
  SearchCubit() : super( SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? sModel;
 void Search({
   required String text
 }){
   emit(SearchLoadingState());
   DioHelper.postData(
       url: search,
       token:istoken!,
       data: {
       'text':text,
       }).then((value) {
     sModel = SearchModel.fromjson(value.data);
     print(sModel!.data!.productl![0]);
     emit(SearchSuccessState());
   }).catchError((error){
         emit(SearchErrorState(error));
         print(error.toString());
   });
 }
}