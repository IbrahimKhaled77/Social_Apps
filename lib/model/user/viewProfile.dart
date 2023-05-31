
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/models/modelregister.dart';

class ViewProfileSocial extends StatelessWidget {

    final RegisterModel model;

  const ViewProfileSocial({super.key, required this.model});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLayoutSocial,LayoutStates>(
        listener: (context ,state){

        },
        builder: (context,state) {
          //var model=CubitLayoutSocial.get(context).model!;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 230.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),

                              ),
                            ),
                            child: Image(
                              image: NetworkImage('${model.imageCover}') ,
                              fit: BoxFit.cover,
                              height: 190.0,

                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 49.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 48.0,
                            backgroundImage: NetworkImage('${model.imageProfile}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(model.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text('${model.bio}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            Text('100'),
                            SizedBox(height: 5.0,),
                            Text('Post',style: TextStyle(color: Colors.teal),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            Text('265'),
                            SizedBox(height: 5.0,),
                            Text('Photos',style: TextStyle(color: Colors.teal),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            Text('10K'),
                            SizedBox(height: 5.0,),
                            Text('Followers',style: TextStyle(color: Colors.teal),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            Text('64'),
                            SizedBox(height: 5.0,),
                            Text('Followings',style: TextStyle(color: Colors.teal),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),




                ],
              ),
            ),
          );
        }
    );
  }
}
