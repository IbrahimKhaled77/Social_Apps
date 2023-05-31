// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/shared/Styles/Icon/icons.dart';
import 'package:soical/shared/components/components.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {

  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();

  EditProfile({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLayoutSocial,LayoutStates>(
      listener: (context ,state){




      },
      builder: (context,state) {
        var model=CubitLayoutSocial.get(context).modelRegister!;
        var cubit=CubitLayoutSocial.get(context);
        nameController.text=model.name;
        bioController.text=model.bio!;
        phoneController.text=model.phone;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Edit Profile',style: TextStyle(fontSize: 25.0),),
            actions: [
              TextButton(
                  onPressed: (){
                    if(cubit.imagePickerProfile != null ){
                      cubit.uploadImageProfile(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                    }
                     if( cubit.imagePickerCover != null){
                      cubit.uploadImageCover(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                    }
                     cubit.userUpdate(name: nameController.text, phone: phoneController.text, bio: bioController.text);



                  },
                  child: const  Text('update',style:TextStyle(fontSize: 17.0) ,),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is EditProfileUserUpdateLoadingStates || state is LayoutGetUserLoadingStates)
                    const LinearProgressIndicator(),
                  if(state is EditProfileUserUpdateLoadingStates || state is LayoutGetUserLoadingStates)
                    const SizedBox(height: 10.0,),
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
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image(
                                  image:cubit.imagePickerCover == null ?NetworkImage('${model.imageCover}') : FileImage(cubit.imagePickerCover!) as ImageProvider,
                                  fit: BoxFit.cover,
                                  height: 190.0,
                                  width: double.infinity,

                                ),
                                IconButton(
                                  color: Colors.teal.shade400,
                                  onPressed:(){
                                    cubit.getPickerCover();
                                  },
                                  icon:  CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: Colors.teal.shade400,
                                    child: const  Icon(IconBroken.Camera,size: 25.0,color: Colors.white,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 49.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(

                            radius: 48.0,
                            backgroundImage: cubit.imagePickerProfile==null ? NetworkImage('${model.imageProfile}') :FileImage(cubit.imagePickerProfile!) as ImageProvider,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top:70.0 ,
                            left:70.0 ,
                          ),
                          child: IconButton(
                            onPressed:(){
                              cubit.getPickerProfile();
                            },
                            icon:  CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.teal.shade400,
                              child: const Icon(IconBroken.Camera,size: 25.0,color: Colors.white,),
                            ),
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
                            label:const Text('bio'),
                            controller: bioController,
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




                        ],

                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
