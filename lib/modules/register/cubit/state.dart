import 'package:shop_app/models/login_model/login.dart';

abstract class ShopRegisterStates{}

class ChangeRegisterPasswordVisibility extends ShopRegisterStates{}

 class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessfulState extends ShopRegisterStates{
  final  ShopLoginModel loginModel;
  ShopRegisterSuccessfulState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}