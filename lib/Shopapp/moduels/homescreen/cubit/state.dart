abstract class ShopAppState {}

class InitialShopAppState extends ShopAppState{}

class GetHomeDataSuccessState extends ShopAppState{}

class GetHomeDataErrorState extends ShopAppState{}

class ChangeCurrentIndexState extends ShopAppState{}

class GetCategoriesSuccess extends ShopAppState{}

class GetCategoriesError extends ShopAppState{}

class AddOrChangeFavoritesSuccessState extends ShopAppState{
  bool ?status;
  AddOrChangeFavoritesSuccessState(this.status);

}

class AddOrChangeFavoritesErrorState extends ShopAppState{
  bool ?status;
  AddOrChangeFavoritesErrorState(this.status);

}

class GetFavorateDataSuccess extends ShopAppState{}

class GetFavorateDataError extends ShopAppState{}

class LoadingGetFavorateData extends ShopAppState{}

class GetProfileDataSuccess extends ShopAppState{}

class GetProfileDataError extends ShopAppState{}

class UpdateDataSuccesState extends ShopAppState{}

class UpdataDataErrorState extends ShopAppState{}

class LoadingUpdateProfile extends ShopAppState{}

class SerachSuccessState extends ShopAppState{}

class SerachErrorState extends ShopAppState{}








