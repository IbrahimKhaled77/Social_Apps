import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/LayoutHome.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/model/Forget_Password/forget_password.dart';
import 'package:soical/model/login/cubit/cubit.dart';
import 'package:soical/model/login/cubit/states.dart';
import 'package:soical/model/register/register.dart';
import 'package:soical/shared/SharedPreferences/SharedPreferences.dart';
import 'package:soical/shared/components/components.dart';
import 'package:soical/shared/constant/constant.dart';

// ignore: must_be_immutable
class SocialLogin extends StatelessWidget {


  var emailController=TextEditingController();
  var passwordController=TextEditingController();
 var keys=GlobalKey<FormState>();

  SocialLogin({super.key});
  @override
  Widget build(BuildContext context) {
   return Builder(

     builder: (context) {
       uidR=Preference.getData(key: 'uidR');
       if (kDebugMode) {
         print("reagister uid login $uidR");
       }
       return BlocProvider(
           create:(BuildContext context)=>CubitLogin(),
       child: BlocConsumer<CubitLogin,LoginStates>(
         listener: (context,state){
           if(state is LoginUserLoginLErrorStates){
             showToast(text: state.error, state: ToastState.error);

           }
           if(state is LoginUserLoginLSuccessStates){
             Preference.saveData(key: 'uid', value:state.uid).then((value) {
               uid=  Preference.getData(key: 'uid');
               showToast(text: 'Success', state: ToastState.success).then((value) {
                 if (kDebugMode) {
                   print('LoginUserLoginLshowToast $uidLogin');
                 }
                  defaultNav(context, const LayoutSocial());

               });

             });


           }

         },
         builder: (context,state){
           var cubit =CubitLogin.get(context);
           return Scaffold(
             appBar: AppBar(),
             body: Center(
               child: SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key:keys,
                     child: Column(

                       children: [
                         const Text('Login',style: TextStyle(color: Colors.teal ,fontSize: 40.0 ),),
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
                                   suffixIcon: cubit.suffixIcon,
                                   suffix: (){
                                     cubit.changeButtonPasswordLogin();
                                   },
                                 ),
                                 const SizedBox(height: 15.0,),
                                 defaultTextButton(
                                   function:  (){
                                     defaultNavigator(context, SocialRegister());
                                   } ,
                                   text: 'Don\'t have an account?',
                                 ),
                                 defaultTextButton(
                                   function:  (){
                                    defaultNavigator(context, ForgetPassword());
                                   } ,
                                   text:'forgot the password?',
                                 ),
                                 const SizedBox(height: 25.0,),
                                 ConditionalBuilder(
                                     condition: state is! LoginUserLoginLoadingStates,
                                     builder: (context)=>  defaultButton(
                                         function: (){
                                           if(keys.currentState!.validate()){

                                             cubit.userLogin(email: emailController.text, password: passwordController.text);




                                           }
                                         },
                                         text: 'sign in',
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
