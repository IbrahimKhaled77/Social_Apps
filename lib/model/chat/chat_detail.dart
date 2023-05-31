import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/models/modelChat.dart';
import 'package:soical/models/modelregister.dart';
import 'package:soical/shared/Styles/Icon/icons.dart';

// ignore: must_be_immutable
class ChatDetails extends StatelessWidget {

  final RegisterModel modelR;


 var messageController=TextEditingController();

   ChatDetails({super.key, required this.modelR});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        CubitLayoutSocial
            .get(context)
            .getChat(
            reserve:modelR.uid,

        );
        return BlocConsumer<CubitLayoutSocial,LayoutStates>(
            listener: (context ,state){

            },

          builder:(context ,state) {
              var cubit=CubitLayoutSocial.get(context);
             // var cubit=CubitLayoutSocial.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title:  Row(
                  children: [
                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage('${modelR.imageProfile}'),
                    ),
                    const SizedBox(width: 10.0,),
                    Expanded(
                      child: Text(
                        modelR.name,
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize:19.0 ,
                          height: 0.5,
                        ),
                      maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                titleSpacing: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context , index){
                          if (cubit.chatList[index].sender == cubit.modelRegister!.uid ){
                            return  buildMessageS(context,cubit.chatList[index]);
                          }
                          else{
                            return  buildMessageR(context,cubit.chatList[index]);
                          }

                          },
                          separatorBuilder: (context , index)=>const SizedBox(height: 15.0,),
                          itemCount: cubit.chatList.length,
                      ),
                    ),
                  /*  Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: cubit.imageChatPicker ==null ? NetworkImage('https://4.bp.blogspot.com/-hFS5a0qq634/WgBTntCD-zI/AAAAAAAAX7o/a9eoPJs5AVkIeYN1Ff2bVZYiDMPjWCpIACEwYBhgL/s1600/Red%2BRose3.jpg') : FileImage(cubit.imageChatPicker!) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),*/
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:messageController,
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'write text...',
                              hintStyle: const TextStyle(
                                height: 1.0,
                              ),
                              labelStyle: const TextStyle(
                                height: 1.0,
                              ),
                              counterStyle: const TextStyle(
                                height: 1.0,
                              ),

                            ),
                            textAlign: TextAlign.start,

                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        IconButton(
                            onPressed: (){
                               if(CubitLayoutSocial.get(context).imagePickerPost == null){
                                 cubit.sendChat(
                                   reserve: modelR.uid,
                                   text: messageController.text,
                                   datetime: DateTime.now().toString(),

                                 );
                               }else{
                                /* cubit.sendImageChat(
                                   reserve: modelR.uid,
                                   datetime: DateTime.now().toString(),
                                   text: messageController.text,
                                 );*/
                               }


                            },
                            icon: Icon(IconBroken.Send,color: Colors.teal.shade400,),
                        ),
                        IconButton(
                          onPressed: (){
                                cubit.imagePickerChat().then((value) {
                                  cubit.sendImageChat(
                                    reserve: modelR.uid,
                                    datetime: DateTime.now().toString(),
                                    //text: messageController.text,
                                  );
                                });
                          },
                          icon: Icon(IconBroken.Image,color: Colors.teal.shade400,),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}

Widget buildMessageR(context,ModelChat model)=>Align(
  alignment: AlignmentDirectional.topStart,
  child: Column(
    children: [
      if(model.text != '')
        Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical:10.0 ,
            horizontal:10.0 ,
          ),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart:  Radius.circular(10.0),
              topEnd:  Radius.circular(10.0),

            ),
          ),
          child: Text(
            '${model.text}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,


            ),
          ),
        ),
      ),
      if(model.text != '' || model.image != '' )
        const SizedBox(height: 20.0 ,),
      if(model.image != '')
      Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          height: 400.0,

          padding: const EdgeInsetsDirectional.symmetric(
            vertical:10.0 ,
            horizontal:10.0 ,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey,
          ),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.teal.shade400,
            ),
            child: Image(
              image:NetworkImage('${model.image}') ,
              fit: BoxFit.cover,
              height: 290.0,
              width: 210.0,
            ),
          ),
        ),
      ),
    ],
  ),
);


Widget buildMessageS(context,ModelChat model)=> Align(
  alignment: AlignmentDirectional.bottomEnd,
  child: Column(
    children: [
      if(model.text != '')
      Align(
  alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical:10.0 ,
            horizontal:10.0 ,
          ),
          decoration: BoxDecoration(
            color: Colors.teal.shade400,
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart:  Radius.circular(10.0),
              topEnd:  Radius.circular(10.0),

            ),
          ),
          child: Text(
            '${model.text}',
            style:
            const TextStyle(
              color: Colors.white,
              fontSize: 17.0,

            ),

          ),
        ),
      ),
      if(model.text != '' || model.image != '' )
      const SizedBox(height: 20.0 ,),
      if(model.image != '')
      Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          height: 400.0,

          padding: const EdgeInsetsDirectional.symmetric(
            vertical:10.0 ,
            horizontal:10.0 ,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.teal.shade400,
          ),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.teal,
            ),
            child: Image(
              image:NetworkImage('${model.image}') ,
              fit: BoxFit.cover,
              height: 290.0,
              width: 210.0,
            ),
          ),
        ),
      ),
    ],
  ),
);