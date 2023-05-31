


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/model/register/cubit/states.dart';
import 'package:soical/models/modelregister.dart';
import 'package:soical/shared/constant/constant.dart';

class CubitRegister extends Cubit<RegisterStates>{
  CubitRegister( ):super(RegisterInitStates());

  static CubitRegister get(context)=>BlocProvider.of(context);

    IconData suffixIcon=Icons.visibility_off_rounded;
    bool isPassword=true;
    void changeButtonPasswordRegister(){
      isPassword=!isPassword;
      suffixIcon = isPassword ?Icons.visibility_off_rounded : Icons.visibility;
      emit(RegisterChangeButtonPasswordRegisterStates());
    }




   void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterUserRegisterLoadingStates());
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,
    )
        .then((value) {
        uuu=value.user!.uid;
          createUserRegister(
            name: name,
            email: email,
            password: password,
            uids: value.user!.uid,
            phone: phone,
          );
          emit(RegisterUserRegisterSuccessStates(value.user!.uid));
    })
        .catchError((onError){
          emit(RegisterUserRegisterErrorStates(onError.toString()));
    });

  }

    void createUserRegister({
      required String name,
      required String email,
      required String password,
      required String uids,
      required String phone,
}){

     // emit(RegisterCreateUserRegisterLoadingStates());
      RegisterModel model=RegisterModel(
          name: name,
          email: email,
          password: password,
          uid: uids,
          phone: phone,
          bio: 'write a bio',
        imageProfile: 'https://img.freepik.com/premium-psd/3d-illustration-business-man-with-glasses_23-2149436193.jpg?w=740',
        imageCover: 'https://img.freepik.com/free-psd/3d-rendering-graphic-design_23-2149642704.jpg?w=1060&t=st=1678924455~exp=1678925055~hmac=0af89051544606ec8ae0157412cad2b26246d893fbe1a2cb552b2272f1d702a0',
      );
      FirebaseFirestore
          .instance
          .collection('users')
          .doc(uids)
          .set(model.toMap())
          .then((value) {
        emit(RegisterCreateUserRegisterSuccessStates(uids));
      })
          .catchError((onError){
        emit(RegisterCreateUserRegisterErrorStates(onError.toString()));
      });
    }




}