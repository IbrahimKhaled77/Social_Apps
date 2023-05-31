import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/shared/Styles/Icon/icons.dart';
import 'package:soical/shared/components/components.dart';

// ignore: must_be_immutable
class PostSocial extends StatelessWidget {

var postController=TextEditingController();

  PostSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<CubitLayoutSocial,LayoutStates>(
            listener: (context ,state){
              if(state is CreateNewPostSuccessStates){
                showToast(text: 'Post published', state: ToastState.success);
              }

            },
          builder: (context, state) {
              var cubit=CubitLayoutSocial.get(context);
              var model=CubitLayoutSocial.get(context).modelRegister;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Creat post'),
                titleSpacing: 0.0,
                actions: [
                  defaultTextButton(
                      function: (){
                        var now=DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
                        if(cubit.imagePickerPost == null){
                          cubit.createNewPost(name: model!.name, uid: model.uid, datetime:now , text:postController.text,likes: 0 );
                        }else{
                          cubit.uploadNewPostImage(name: model!.name, uid: model.uid, datetime: now, text: postController.text,likes: 0);
                        }

                      },
                      text: 'Add',
                  ),
                ],

              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    const SizedBox(
                      height: 10.0,
                    ),
                    if(state is CreateNewPostLoadingStates)
                      const LinearProgressIndicator(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26.0,
                          backgroundImage: NetworkImage('${model!.imageProfile}'),

                        ),
                        const SizedBox(width: 9.0,),
                        Text(model.name,style: TextStyle(fontSize: 18.0,color: Colors.teal.shade400,height:0.3 ),),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: TextFormField(
                          controller: postController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'write you bio',
                            hintStyle: TextStyle(
                              color: Colors.grey
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 190.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: cubit.imagePickerPost == null ?const NetworkImage('https://img.freepik.com/free-psd/3d-rendering-graphic-design_23-2149642704.jpg?w=1060&t=st=1678924455~exp=1678925055~hmac=0af89051544606ec8ae0157412cad2b26246d893fbe1a2cb552b2272f1d702a0'):FileImage(cubit.imagePickerPost!) as ImageProvider,
                              fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        IconButton(
                          color: Colors.teal.shade400,
                            onPressed:(){
                            cubit.removePost();
                            },
                            icon:  CircleAvatar(
                              radius: 25.0,
                                backgroundColor: Colors.teal.shade400,
                                child: const Icon(Icons.close,color: Colors.white,size: 18.0,)
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: (){
                        cubit.getImagePost();
                      },
                      child: Padding(
                        padding:  const EdgeInsetsDirectional.symmetric(
                          vertical: 10.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image,color: Colors.teal.shade400,),
                            const SizedBox(width: 8.0,),
                            Text('add photo',style: TextStyle(color: Colors.teal.shade400,),),

                          ],
                        ),
                      ),
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
