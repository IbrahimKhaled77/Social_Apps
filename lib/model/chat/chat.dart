import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/model/chat/chat_detail.dart';
import 'package:soical/models/modelregister.dart';
import 'package:soical/shared/components/components.dart';

class ChatSocial extends StatelessWidget {
  const ChatSocial({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLayoutSocial,LayoutStates>(
      listener: (context ,state){

      },
      builder: (context ,state) {
        var modelChat=CubitLayoutSocial.get(context).userAll;
        return ConditionalBuilder(
          builder: (context)=>SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildUserChat(context,modelChat[index]),
                    separatorBuilder: (context,index)=>  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey[300],
                        height: 1.0,
                      ),
                    ),
                    itemCount: modelChat.length,
                  ),

                ],
              ),
            ),
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator()),
          condition:modelChat.isNotEmpty,

        );
      }
    );
  }
}


Widget buildUserChat(context , RegisterModel modelChat)=> InkWell(

   onTap: (){
     defaultNavigator(context, ChatDetails(modelR:modelChat,));
   },
  child:   Row(

  children: [

  CircleAvatar(

  radius: 33.0,

  backgroundImage: NetworkImage('${modelChat.imageProfile}'),

  ),

  const SizedBox(width: 10.0,),

  Text(

  modelChat.name,

  style: const TextStyle(

  color: Colors.teal,

  fontSize:19.0 ,

  height: 0.5,

  ),),

  ],

  ),
);