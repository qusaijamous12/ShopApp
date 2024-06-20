import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Constants/constants.dart';
import 'package:shopapp/Shared/Diohelper/dioheloer.dart';
import 'package:shopapp/Shared/end_points/endpoints.dart';
import 'package:shopapp/Shopapp/model/CategoriesModel/categire_model.dart';
import 'package:shopapp/Shopapp/model/affFavorate/addfavorate.dart';
import 'package:shopapp/Shopapp/model/getfavorate/getfavorate.dart';
import 'package:shopapp/Shopapp/model/homeModel/home_model.dart';
import 'package:shopapp/Shopapp/model/loginmodel/loginmodel.dart';
import 'package:shopapp/Shopapp/model/updateModel/updateModel.dart';
import 'package:shopapp/Shopapp/moduels/FavorateScreen/favorateScrwewen.dart';
import 'package:shopapp/Shopapp/moduels/SettingScreen/SettingScreen.dart';
import 'package:shopapp/Shopapp/moduels/categoriesscreen/CategoresScreen.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';
import 'package:shopapp/Shopapp/moduels/productScreen/product_screen.dart';

import '../../../model/serachModel/serach_model.dart';

class ShopAppCubit extends Cubit<ShopAppState>{
  ShopAppCubit():super(InitialShopAppState());

  static ShopAppCubit get(context)=>BlocProvider.of(context);
  HomeDataModel ?homeDataModel;
  CategoreisModel ?categoreisModel;
  int currentIndex=0;
  void ChangeCurrentIndex(int index){
    currentIndex=index;
    emit(ChangeCurrentIndexState());
  }
  List<Widget> ChangeScreen=[
    ProductsScreen(),
    CategoriesScreen(),
    FavorateScreen(),
    SettingScreen()

  ];
  Map<dynamic,dynamic> favorate={};

  void GetData(){
    DioHelper.GetData(
        path: GETHOME,
      token: token
    ).then((value) {
      homeDataModel=HomeDataModel.fromJson(value.data);

      print(homeDataModel!.status);
      print(homeDataModel!.data!.banners[0].id);
      homeDataModel!.data!.products.forEach((element) {
        favorate.addAll({
          element.id:element.in_favorites
        });
        print(favorate.toString());

      });
      GetCategoriesData();

     emit(GetHomeDataSuccessState());



    }).catchError((error){
      print(error.toString());
      emit(GetHomeDataErrorState());

    });
  }
  void GetCategoriesData(){
    DioHelper.GetData(
        path: CATEGORIES,

    ).then((value) {
      categoreisModel=CategoreisModel.fromJson(value.data);
      print(categoreisModel!.status);
      GetFavorateData();
      emit(GetCategoriesSuccess());



    }).catchError((error){
      print(error.toString());
      emit(GetCategoriesError());

    });
  }

FavorateModel ?favorateModel;
void AddOrChangeFavorate(int productId){
  favorate[productId]=!favorate[productId];
    DioHelper.PostData(
        path: FAVORITES,
        data: {
          'product_id':productId
        },
      token: token

        ).then((value) {
          favorateModel=FavorateModel.fromJson(value.data);
          print(favorateModel!.message);
          if(favorateModel!.status==false){
            favorate[productId]=!favorate[productId];
          }
          else
            {
              GetFavorateData();
            }

          emit(AddOrChangeFavoritesSuccessState(favorateModel!.status));

    }).catchError((error){
      print(error.toString());
      favorate[productId]=!favorate[productId];
      emit(AddOrChangeFavoritesErrorState(favorateModel!.status));

    });

}
FavorateData ?favorateData;

void GetFavorateData(){
  emit(LoadingGetFavorateData());
  DioHelper.GetData(
      path: FAVORITES,
    token: token
  ).then((value) {

    favorateData=FavorateData.fromJson(value.data);

    print("||||||||||||||||||||||||||||||||||||||||||||||||");
    print(favorateData!.status);
    print(favorateData!.dataFavorate2!.data3[0].productData4!.name);
    GetProfileData();
    emit(GetFavorateDataSuccess());

  }).catchError((error){
    print(error.toString());
    emit(GetFavorateDataError());

  });
}

LoginModel ?userProfile;

void GetProfileData(){
  DioHelper.GetData(
      path: PROFILE,
    token: token
  ).then((value) {
    emit(UpdateDataSuccesState());
    emit(GetProfileDataSuccess());
    userProfile=LoginModel.fromJson(value.data);

  }).catchError((error){
    emit(GetProfileDataError());
  });
}

UpdateModel ?updateModel;
void UpdateProfileData({
    required String name,
  required String email,
  required String phone
}){
  emit(LoadingUpdateProfile());
  DioHelper.UpdateData(
      path: UPDATE,
      data: {
        "name":name,
        "phone":phone,
        "email":email
      },
      token: token).then((value) {
        updateModel=UpdateModel.fromJson(value.data);
        print(updateModel!.message);
        GetProfileData();


  }).catchError((error){
    print(error.toString());
    emit(UpdataDataErrorState());

  });
}

  SerachModel ?serachModel;
void SerachItem(String value){
  DioHelper.PostData(
      path: SERACH,
      token: token,
      data: {
        "text":value
      }).then((value) {
        serachModel=SerachModel.fromJson(value.data);
        emit(SerachSuccessState());

  }).catchError((error){
    print(error.toString());
    emit(SerachErrorState());
  });

}


}