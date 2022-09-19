abstract class ShopHomeSearchState {}

class  SearchInitialState extends ShopHomeSearchState{}

class  SearchLoadingState extends ShopHomeSearchState{}

class SearchSuccessState extends ShopHomeSearchState{}

class SearchErrorState extends ShopHomeSearchState{
  String? error;
  SearchErrorState(error);
}