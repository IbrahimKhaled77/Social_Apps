import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/model/Forget_Password/cubit/state.dart';

class CubitForgetPassword extends Cubit<ForgetPasswordStates>{
  CubitForgetPassword():super(ForgetPasswordInitState());

  static CubitForgetPassword get(context) => BlocProvider.of(context);


  Future resetPassword({
    required String email,
}) async {
    emit(ForgetPasswordLoadingState());
    await FirebaseAuth
        .instance
        .sendPasswordResetEmail(
        email: email,
    ).then((value) {
      emit(ForgetPasswordSuccessState());
    })
        .catchError((error){
      emit(ForgetPasswordErrorState());
    });
  }


}