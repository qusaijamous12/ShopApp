import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/SocialApp/loginsocialApp/cubit/state.dart';

class LoginSocailCubit extends Cubit<LoginSocialState>{
  LoginSocailCubit():super(InitialSocailAppLoginState());
  static LoginSocailCubit get(context)=>BlocProvider.of(context);
  bool isSeucuerText=true;
  IconData ?icon=Icons.visibility_off;
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

  void LoginSocialAccount(context,{
    required String email,
    required String password,
  }){
    emit(LoadingLoginState());
   FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password).then((value) {
         print(value.user!.uid);
         print(value.user!.email);
         emit(LoginSuccessState());

   }).catchError((error){
     print(error.toString());
     emit(LoginErrorState());
   });
  }

}