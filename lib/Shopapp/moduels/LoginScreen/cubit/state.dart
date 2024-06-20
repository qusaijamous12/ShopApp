abstract class LoginState{}

class InitialShopAppLoginState extends LoginState{}

class ChangeIconState extends LoginState{}

class LoginSuccessState extends LoginState{
   bool ?message;
   String ?tokenn;
   LoginSuccessState(this.message,this.tokenn);

}

class LoginErrorState extends LoginState{
  bool ?message;
  LoginErrorState(this.message);
}

class LoadingLoginState extends LoginState{}