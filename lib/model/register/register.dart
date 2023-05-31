import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/LayoutHome.dart';
import 'package:soical/model/register/cubit/cubit.dart';
import 'package:soical/model/register/cubit/states.dart';
import 'package:soical/shared/SharedPreferences/SharedPreferences.dart';
import 'package:soical/shared/components/components.dart';
import 'package:soical/shared/constant/constant.dart';

// ignore: must_be_immutable
class SocialRegister extends StatelessWidget {

  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var keyR=GlobalKey<FormState>();

  SocialRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        return BlocProvider(
          create: (BuildContext context)=>CubitRegister(),
        child: BlocConsumer<CubitRegister,RegisterStates>(
          listener: (context,state){
            if(state is RegisterUserRegisterErrorStates){
              showToast(text: state.error, state: ToastState.error);

            }
            if(state is RegisterUserRegisterSuccessStates){
              Preference.saveData(key: 'uid', value:state.uida).then((value) {
                uid= Preference.getData(key: 'uid');
                showToast(text: 'Success', state: ToastState.success).then((value) {
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>const LayoutSocial()), (route) => false);
                  //CubitLayoutSocial.get(context).getUser();
                 // defaultNav(context, LayoutSocial());
                });
              });

            }


          },
          builder: (context,state){
            var cubit=CubitRegister.get(context);
            return  Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: keyR,
                      child: Column(
                        children: [
                          const Text('Register',style: TextStyle(color: Colors.teal ,fontSize: 40.0 ),),
                          const SizedBox(height: 30.0,),
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
                                    label:const Text('Name'),
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'please enter name';

                                      }
                                    },
                                    password: false,


                                  ),
                                  const SizedBox(height: 20.0,),
                                  defaultTextFromFiled(
                                    label:const Text('E-mail'),
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'please enter Email';

                                      }
                                    },
                                    password: false,


                                  ),
                                  const SizedBox(height: 20.0,),
                                  defaultTextFromFiled(
                                    label:const Text('Password'),
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'please enter password';

                                      }
                                    },
                                    password: cubit.isPassword,
                                    suffixIcon:cubit.suffixIcon,
                                    suffix: (){
                                      cubit.changeButtonPasswordRegister();
                                    },
                                  ),
                                  const SizedBox(height: 20.0,),
                                  defaultTextFromFiled(
                                    label:const Text('phone'),
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return 'please enter phone';

                                      }
                                    },
                                    password: false,

                                  ),


                                  const SizedBox(height: 25.0,),

                                  ConditionalBuilder(
                                      condition: state is! RegisterUserRegisterLoadingStates,
                                      builder: (context)=>defaultButton(
                                          function: (){
                                            if(keyR.currentState!.validate()){

                                              cubit.userRegister(
                                                name: nameController.text,
                                                email: emailController.text,
                                                password: passwordController.text,
                                                phone: phoneController.text,
                                              );



                                            }
                                          },
                                          text: 'Register',
                                          upperCase: true,
                                      ),
                                      fallback: (context)=>const Center(child: CircularProgressIndicator()),
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
