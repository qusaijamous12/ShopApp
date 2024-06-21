import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/SocialApp/modelSocial/Socail_model.dart';
import 'package:shopapp/SocialApp/registerSocialApp/cubit/state.dart';

class RegisterSocialCubit extends Cubit<RegisterSocailState>{
  RegisterSocialCubit():super(InitialRegisterState());

  static RegisterSocialCubit get(context)=>BlocProvider.of(context);


  void CreateAccount({
    required String name,
    required String email,
    required String phone,
    required String password
  }) {
    emit(LoadingCreateAccount());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          CreateAccountFireStore(name: name, email: email, phone: phone, uId: value.user!.uid);


    }).catchError((error){
      print(error.toString());
      emit(CreateAccountErrorState());
    });

  }

  void CreateAccountFireStore({
    required String name,
    required String email,
    required String phone,
    required String uId

}){
    SocailModel socailModel=SocailModel(name: name,
      email: email,
      phone: phone,
      uId: uId
    );


    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId)
        .set({
      'name':name,
      'phone':phone,
      'email':email,
      'uid':uId
    }).then((value) {
          print('qusai');

      emit(CreateAccountSuccesState());

          emit(CreateAccountFireStoreSuccessState());

    }).catchError((error){
      print(error.toString());

      emit(CreateAccountFireStoreErrorState());

    });
  }



}