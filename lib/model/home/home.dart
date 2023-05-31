import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/models/modelPost.dart';
import 'package:soical/shared/Styles/Icon/icons.dart';

// ignore: camel_case_types
class homeSocial extends StatelessWidget {
  const homeSocial({super.key});







  @override
  Widget build(BuildContext context)  {

    return  Builder (
      builder: (context) {
        CubitLayoutSocial.get(context).getNewPost(context);


        return BlocConsumer<CubitLayoutSocial,LayoutStates>(
            listener: (context , state){},

            builder: (context ,state) {
              return ConditionalBuilder (
                condition: CubitLayoutSocial.get(context).post.isNotEmpty && CubitLayoutSocial.get(context).uidPost.isNotEmpty &&CubitLayoutSocial.get(context).numberLikess.isNotEmpty ,
                builder: (context)=>  SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(

                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft:Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: const Card(
                                elevation: 10.0,
                                // margin: EdgeInsets.symmetric(horizontal: 20.0),
                                //clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image(
                                  image: NetworkImage('https://img.freepik.com/free-psd/3d-rendering-graphic-design_23-2149642704.jpg?w=1060&t=st=1678924455~exp=1678925055~hmac=0af89051544606ec8ae0157412cad2b26246d893fbe1a2cb552b2272f1d702a0'),
                                  fit: BoxFit.cover,
                                  height: 190.0,


                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('communicate with friends',style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,index) =>CubitLayoutSocial.get(context).post.isNotEmpty ? buildCard(context,CubitLayoutSocial.get(context).post[index],index) : const Text('not'),
                          separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                          itemCount:CubitLayoutSocial.get(context).post.length,
                        ),


                      ],
                    ),
                  ),
                ),
                fallback:(context)=>const Center(child: CircularProgressIndicator()) ,

              );
            }
        );
      }
    );
  }

  Widget buildCard(context,ModelPost model,index)=> Card (
    elevation: 6.0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar( //model.imageProfile
                      backgroundImage: model.uid ==CubitLayoutSocial.get(context).modelRegister!.uid? NetworkImage('${CubitLayoutSocial.get(context).modelRegister!.imageProfile}') :NetworkImage('${model.imageProfile}')  ,
                      radius: 33.0,
                    ),
                    const SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(model.name,style: const TextStyle(fontSize: 18.0,color: Colors.teal,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 5.0,),
                            const Icon(Icons.check_circle , color: Colors.blue,size: 18.0,),
                          ],
                        ),
                        const SizedBox(height: 8.0,),
                        Text(model.datetime,style: const TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.add_box_outlined ,color: Colors.teal,),
              ),
            ],
          ),
          Padding(
            padding:  const EdgeInsetsDirectional.symmetric(
              vertical: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],

            ),
          ),
          if(model.text != '')
            Padding(
              padding:  const EdgeInsetsDirectional.only(
                top: 8.0,
                bottom: 15.0,
              ),
              child: Text('${model.text}',
                style: const TextStyle(
                  fontSize: 15.0,
                  height: 1.4,
                ),
              ),
            ),
          const SizedBox(height: 10.0,),
          if(model.imagePost != '')
            Container(
              height: 190.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:  NetworkImage('${model.imagePost}'),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          const SizedBox(height: 10.0,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    CubitLayoutSocial.get(context).removeLike(uidPost: CubitLayoutSocial.get(context).uidPost[index]);
                  },
                  child: Row(
                    children: [
                      const Icon(IconBroken.Heart,size: 22.0,color: Colors.redAccent,),
                      const SizedBox(width: 5.0,),
                      Text('${
                         CubitLayoutSocial.get(context).numberLikess[CubitLayoutSocial.get(context).uidPost[index]]

                     }',
                        style:
                       const TextStyle(
                           color: Colors.grey,
                           fontSize: 15.0,
                       ),),

                    ],
                  ),
                ),
              ),
             /* Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    children: [
                      Icon(Icons.chat_outlined,size: 22.0,color: Colors.amber,),
                      SizedBox(width: 5.0,),
                      Text('120 Comment',style: TextStyle(color: Colors.grey,fontSize: 15.0),),


                    ],
                  ),
                ),
              ),*/
            ],
          ),
          Padding(
            padding:  const EdgeInsetsDirectional.symmetric(
              vertical: 13.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],

            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${CubitLayoutSocial.get(context).modelRegister!.imageProfile}'),
                      radius: 28.0,
                    ),
                    const SizedBox(width: 8.0,),
                    InkWell(
                      child: const Text('Write a comment',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: (){},

                    ),
                  ],
                ),
              ),
              Expanded(

                child: InkWell(
                  onTap: (){
                    CubitLayoutSocial.get(context).likesPost(uidPost: CubitLayoutSocial.get(context).uidPost[index],
                    );


                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(IconBroken.Heart,size: 22.0,color: Colors.redAccent,),
                      SizedBox(width: 5.0,),
                      Text('Like',style: TextStyle(color: Colors.grey,fontSize: 15.0),),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

