abstract class ShopHomeStates {}

class InitialBottomNavState extends ShopHomeStates{}

class ChangeBottomNavState extends ShopHomeStates{}

class ShopHomeLoadingState extends ShopHomeStates{}

class ShopHomeSuccessState extends ShopHomeStates{}

class ShopHomeErrorState extends ShopHomeStates{
  String? error;
  ShopHomeErrorState(this.error);
}
class ShopCategoriesLoadingState extends ShopHomeStates{}

class ShopCategoriesSuccessState extends ShopHomeStates{}

class ShopCategoriesErrorState extends ShopHomeStates{
  String? error;
  ShopCategoriesErrorState(this.error);
}