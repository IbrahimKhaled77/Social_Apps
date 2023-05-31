
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/model/login/cubit/states.dart';
import 'package:soical/shared/constant/constant.dart';

class CubitLogin extends Cubit<LoginStates>{
  CubitLogin( ):super(LoginInitStates());

  static CubitLogin get(context)=>BlocProvider.of(context);

  IconData suffixIcon=Icons.visibility_off_rounded;
  bool isPassword=true;
  void changeButtonPasswordLogin(){
    isPassword=!isPassword;
    suffixIcon = isPassword ?Icons.visibility_off_rounded : Icons.visibility;
    emit(LoginChangeButtonPasswordLoginStates());
  }

  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginUserLoginLoadingStates());
    FirebaseAuth
        .instance
        .signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      uidLogin=value.user!.uid;
     // print(uidLogin);
      //print(value.user!.uid);
      //print("uidRRRRRRR Re1 ${uidR}");
      emit(LoginUserLoginLSuccessStates(value.user!.uid));
     // print('LoginUserLoginLSuccesssss ${uidLogin}');
    }).catchError((onError){
      emit(LoginUserLoginLErrorStates(onError.toString()));
    });


  }







}