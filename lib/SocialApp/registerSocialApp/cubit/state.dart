abstract class RegisterSocailState {}

class InitialRegisterState extends RegisterSocailState{}

class LoadingCreateAccount extends RegisterSocailState{}

class CreateAccountSuccesState extends RegisterSocailState{


}

class CreateAccountErrorState extends RegisterSocailState{


}

class LoadingCreateAccountFireStoreState extends RegisterSocailState{}

class CreateAccountFireStoreSuccessState extends RegisterSocailState{}

class CreateAccountFireStoreErrorState extends RegisterSocailState{}

