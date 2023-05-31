abstract class LoginStates{}

class LoginInitStates extends LoginStates{}

class LoginChangeButtonPasswordLoginStates extends LoginStates{}

class LoginUserLoginLoadingStates extends LoginStates{}

class LoginUserLoginLSuccessStates extends LoginStates{
  final String uid;
  LoginUserLoginLSuccessStates(this.uid);
}

class LoginUserLoginLErrorStates extends LoginStates{
  final String error;

  LoginUserLoginLErrorStates(this.error);
}


