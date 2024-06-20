import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Diohelper/dioheloer.dart';
import 'package:shopapp/Shared/end_points/endpoints.dart';
import 'package:shopapp/Shopapp/model/loginmodel/loginmodel.dart';
import 'package:shopapp/Shopapp/moduels/registerscreen/cubit/state.dart';

class RegisterShopCubit extends Cubit<RegisterShopState>{
  RegisterShopCubit():super(InitialRegisterState());

  static RegisterShopCubit get(context)=>BlocProvider.of(context);
  LoginModel ?registerModel;

  void CreateAccount({
    required String name,
    required String email,
    required String phone,
    required String password
}){
    emit(LoadingCreateAccount());
    DioHelper.PostData(
        path: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone
        }).then((value) {
          print(value.data);
          emit(CreateAccountSuccesState());

    }).catchError((error){
      print(error.toString());
      emit(CreateAccountErrorState());
    });

  }


}