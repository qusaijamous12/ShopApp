abstract class RegisterShopState {}

class InitialRegisterState extends RegisterShopState{}

class LoadingCreateAccount extends RegisterShopState{}

class CreateAccountSuccesState extends RegisterShopState{
  // bool ?status;
  // CreateAccountSuccesState(this.status);

}

class CreateAccountErrorState extends RegisterShopState{
  // bool ?status;
  // CreateAccountErrorState(this.status);

}