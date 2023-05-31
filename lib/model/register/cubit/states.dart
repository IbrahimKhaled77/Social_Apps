
abstract class RegisterStates{}

class RegisterInitStates extends RegisterStates{}

class RegisterChangeButtonPasswordRegisterStates extends RegisterStates{}

class RegisterUserRegisterLoadingStates extends RegisterStates{}

class RegisterUserRegisterSuccessStates extends RegisterStates{
  final String uida;

  RegisterUserRegisterSuccessStates(this.uida);


}

class RegisterUserRegisterErrorStates extends RegisterStates{
  final String error;

  RegisterUserRegisterErrorStates(this.error);
}




class RegisterCreateUserRegisterLoadingStates extends RegisterStates{}

class RegisterCreateUserRegisterSuccessStates extends RegisterStates{
  final String uids;

  RegisterCreateUserRegisterSuccessStates(this.uids);


}

class RegisterCreateUserRegisterErrorStates extends RegisterStates{
  final String error;

  RegisterCreateUserRegisterErrorStates(this.error);
}
