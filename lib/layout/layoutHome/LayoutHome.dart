
// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/model/post/post.dart';
import 'package:soical/shared/Styles/Icon/icons.dart';
import 'package:soical/shared/components/components.dart';

class LayoutSocial extends StatelessWidget {
  const LayoutSocial({super.key});



  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (context) {
       // CubitLayoutSocial.get(context).getNewPost(context);
        return BlocConsumer<CubitLayoutSocial,LayoutStates>(
            listener: (context,state){
              if(state is LayoutChangeNavBarPostSuccessStates){
                defaultNavigator(context,PostSocial() );
              }

            },
            builder: (context,state) {
              var cubit=CubitLayoutSocial.get(context);
              return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    title: cubit.screenTitle[cubit.index],

                  ),
                  body: cubit.screen[cubit.index],
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: (index){
                      cubit.changeNavBar(index);
                    },
                    currentIndex: cubit.index,
                    items:  const [
                      BottomNavigationBarItem(
                        label:'Home' ,
                        icon:Icon(IconBroken.Home) ,

                      ),
                      BottomNavigationBarItem(
                        label:'User' ,
                        icon:Icon(IconBroken.User) ,

                      ),
                      BottomNavigationBarItem(
                        label:'Post' ,
                        icon:Icon(IconBroken.Arrow___Up_Circle) ,

                      ),
                      BottomNavigationBarItem(
                        label:'Chat' ,
                        icon:Icon(IconBroken.Chat) ,

                      ),
                      BottomNavigationBarItem(
                        label:'Setting' ,
                        icon:Icon(IconBroken.Setting) ,

                      ),
                    ],
                    unselectedItemColor: Colors.grey,
                    // backgroundColor: Colors.white,
                    elevation: 0.0,
                    showUnselectedLabels: true,
                    selectedItemColor: Colors.teal.shade400,
                    type: BottomNavigationBarType.fixed,

                  ),



              );

            }
        );
      }
    );
  }
}
