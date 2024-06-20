import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Constants/constants.dart';
import 'package:shopapp/Shared/Diohelper/dioheloer.dart';
import 'package:shopapp/Shared/end_points/endpoints.dart';
import 'package:shopapp/Shopapp/model/loginmodel/loginmodel.dart';
import 'package:shopapp/Shopapp/moduels/LoginScreen/cubit/state.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';

import '../../../../Shared/CasheHelper/cashe_helper.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(InitialShopAppLoginState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  bool isSeucuerText=true;
  IconData ?icon=Icons.visibility_off;
  LoginModel ?loginModel;
  void ChnageIcon(){
    isSeucuerText=!isSeucuerText;
    if(isSeucuerText){
      icon=Icons.visibility_off;
    }
    else
      {
        icon=Icons.visibility;
      }
    emit(ChangeIconState());
  }

  void LoginPostData(context,{
    required String email,
    required String password,
}){
    emit(LoadingLoginState());
    DioHelper.PostData(
        path: LOGIN,
        data: {
          'email':email,
          'password':password
        }).then((value) {
          loginModel=LoginModel.fromJson(value.data);
          print(loginModel!.status);
          print(loginModel!.data!.id);
          print(loginModel!.data!.token);
          if(loginModel!.status==true) {
            CasheHelper.SaveData(key: 'token', data: loginModel!.data!.token!);
            token=loginModel!.data!.token;
            print(token);
            ShopAppCubit.get(context).GetData();
            ShopAppCubit.get(context).GetCategoriesData();
            ShopAppCubit.get(context).GetFavorateData();
            ShopAppCubit.get(context).GetProfileData();

          }



          emit(LoginSuccessState(loginModel!.status,loginModel!.data!.token));


    }).catchError((error){
      emit(LoginErrorState(loginModel!.status));
    });
  }

}

//   IGrZSWRi96sbVztIt3esYBNhVXmYHvCHnzLh6AqP2ld95yXXNJjrCfhHT7CgPxiToGKg0t