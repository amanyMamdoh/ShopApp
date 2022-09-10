import 'package:shop_app/models/login_model/login.dart';

abstract class ShopLoginStates{}

class ChangePasswordVisibility extends ShopLoginStates{}

 class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessfulState extends ShopLoginStates{
  final  ShopLoginModel loginModel;
  ShopLoginSuccessfulState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}