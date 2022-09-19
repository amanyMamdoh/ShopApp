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
class ChangeFavoriteModelLoadingState extends ShopHomeStates{}

class ChangeFavoriteModelSuccessState extends ShopHomeStates{}

class ChangeFavoriteModelState extends ShopHomeStates{}

class ChangeFavoriteModelErrorState extends ShopHomeStates{
  String? error;
  ChangeFavoriteModelErrorState(this.error);
}
class  GetFavoriteLoadingState extends ShopHomeStates{}

class GetFavoriteSuccessState extends ShopHomeStates{}

class GetFavoriteErrorState extends ShopHomeStates{
  String? error;
  GetFavoriteErrorState(error);
}
class  GetUserLoadingState extends ShopHomeStates{}

class GetUserSuccessState extends ShopHomeStates{}

class GetUserErrorState extends ShopHomeStates{
  String? error;
  GetUserErrorState(error);
}
class  UpdateUserLoadingState extends ShopHomeStates{}

class UpdateUserSuccessState extends ShopHomeStates{}

class UpdateUserErrorState extends ShopHomeStates{
  String? error;
  UpdateUserErrorState(error);
}
