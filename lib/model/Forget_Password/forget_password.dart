import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/model/Forget_Password/cubit/cubit.dart';
import 'package:soical/model/Forget_Password/cubit/state.dart';
import 'package:soical/shared/components/components.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {

var emailController=TextEditingController();

   var keys=GlobalKey<FormState>();

  ForgetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        String? email= CubitLayoutSocial.get(context).modelRegister?.email;
        return BlocProvider(
          create: (BuildContext context)=>CubitForgetPassword(),
          child: BlocConsumer<CubitForgetPassword,ForgetPasswordStates>(
            listener: (context,state){
              if(state is ForgetPasswordErrorState){
                showToast(text: 'Error ResetPassword', state: ToastState.error);

              }
              if(state is ForgetPasswordSuccessState){
                showToast(text: 'Success SendMessage to Email', state: ToastState.success);

              }


            },
            builder: (context,state){
              var cubit=CubitForgetPassword.get(context);
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key:keys,
                        child: Column(
                          children: [
                             Text('Reset password',style: TextStyle(fontSize: 21.0,color:Colors.teal.shade500,),),
                            const SizedBox(height: 15.0,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20.0),
                                  bottomEnd:Radius.circular(20.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    defaultTextFromFiled(
                                      label:const Text('E-mail'),
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String? value){
                                        if(value!.isEmpty ){
                                          return 'please enter Email';

                                        } if(email == emailController.text){
                                          return 'The email you entered does not match your personal email';
                                        }
                                      },
                                      password: false,


                                    ),
                                    const SizedBox(height: 20.0,),
                                    ConditionalBuilder(
                                      condition: state is! ForgetPasswordLoadingState,
                                      builder: (context)=>  defaultButton(
                                          function: (){
                                            if(keys.currentState!.validate()){

                                              cubit.resetPassword(email:emailController.text.trim());




                                            }
                                          },
                                          text: 'Reset password',
                                          upperCase: true
                                      ),
                                      fallback: (context)=>const Center(child: CircularProgressIndicator(),) ,
                                    ),

                                  ],

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },

          ),
        );
      }
    );
  }
}
