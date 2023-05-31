

import 'dart:io';




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soical/layout/layoutHome/cubit/states.dart';
import 'package:soical/model/chat/chat.dart';
import 'package:soical/model/home/home.dart';
import 'package:soical/model/post/post.dart';
import 'package:soical/model/setting/setting.dart';
import 'package:soical/model/user/user.dart';
import 'package:soical/models/modelChat.dart';
import 'package:soical/models/modelPost.dart';
import 'package:soical/models/modelregister.dart';
import 'package:soical/shared/constant/constant.dart';


class CubitLayoutSocial extends Cubit<LayoutStates> {
  CubitLayoutSocial() :super(LayoutInitStates());

  static CubitLayoutSocial get(context) => BlocProvider.of(context);
  RegisterModel? modelRegister;
  ModelPost? modelPosts;




 void getUser() {


  if(uid != null){
      emit(LayoutGetUserLoadingStates());
      // print(modelRegister!.uid);
      FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value)  {

        //سوال ليش
        modelRegister =  RegisterModel.fromJson(value.data()!);
        emit(LayoutGetUserSuccessStates());
      }).catchError((onError) {
        if (kDebugMode) {
          print(onError.toString());
        }
        emit(LayoutGetUserErrorStates(onError.toString()));
      });
    }

  }

  int index=0;
  List<Widget>screen=[
    const homeSocial(),
    const UserSocial(),
    PostSocial(),
    const ChatSocial(),
    const SettingSocial(),
  ];

  List<Widget>screenTitle=[
    const Text('home'),
    const Text('user'),
    const Text('post'),
    const Text('chat'),
    const Text('setting'),
  ];


  void changeNavBar(int indexNav){

    if(indexNav == 3){
      getUserAll();
    }
    if(indexNav == 1){
      getUserAll();
    }


    if(indexNav==2) {
     emit(LayoutChangeNavBarPostSuccessStates());
    }else{
      index = indexNav;
      emit(LayoutChangeNavBarSuccessStates());
    }


  }

  File? imagePickerProfile;
  final ImagePicker picker = ImagePicker();
  Future<void> getPickerProfile() async {
    final imageProfile = await picker.pickImage(source: ImageSource.gallery);
   if(imageProfile !=null){
     imagePickerProfile=File(imageProfile.path);
     emit(EditProfileGetPickerProfileSuccessStates());
   }else{
     if (kDebugMode) {
       print('not selected');
     }
     emit(EditProfileGetPickerProfileErrorStates());
   }

  }
    String? uriImageProfile;
  void uploadImageProfile({
    required String name,
    required String phone,
    required String bio,

  }){
    emit(EditProfileUserUpdateLoadingStates());
    FirebaseStorage
        .instance
        .ref()
        .child(Uri.file('usera/${imagePickerProfile!.path}').pathSegments.last)
        .putFile(imagePickerProfile!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            uriImageProfile=value;
            userUpdate(name: name, phone: phone, bio: bio,image: value);
          });

    })
        .catchError((onError){
          print(onError.toString());
          emit(EditProfileUploadImageProfileErrorStates());
    });


  }


  File? imagePickerCover;
  Future<void>getPickerCover() async{
    final imageCover= await picker.pickImage(source:ImageSource.gallery );
    if(imageCover != null){
      imagePickerCover=File(imageCover.path);
      emit(EditProfileGetPickerCoverSuccessStates());
    }else{
      if (kDebugMode) {
        print('not selected');
      }
      emit(EditProfileGetPickerCoverErrorStates());
    }

  }

  String? uriImageCover;
  void uploadImageCover({
    required String name,
    required String bio,
    required String phone,


  }){
    emit(EditProfileUserUpdateLoadingStates());
    FirebaseStorage
        .instance
        .ref()
        .child(Uri.file('usera/${imagePickerCover!.path}').pathSegments.last)
        .putFile(imagePickerCover!)
        .then((value){
              value
              .ref
              .getDownloadURL()
              .then((value) {
            uriImageCover=value;
            userUpdate(name: name, phone: phone, bio: bio,cover: value);
          });
        }).catchError((onError){
          emit(EditProfileGetPickerCoverErrorStates());
    });

  }








void userUpdate({
  required String name,
  required String phone,
  required String bio,
      String?  image,
       String? cover,

}){


    RegisterModel modeles =RegisterModel(
        name: name,
        email:modelRegister!.email ,
        password: modelRegister!.password,
        uid: modelRegister!.uid,
        phone: phone,
      bio: bio,
      imageCover: cover ?? modelRegister!.imageCover,
      imageProfile: image ?? modelRegister!.imageProfile,
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .update(modeles.toMap())
        .then((value) {
          getUser();
          //emit(EditProfileUserUpdateSuccessStates());
    })
        .catchError((onError){
          emit(EditProfileUserUpdateErrorStates());
    });

}

//post

File? imagePickerPost;

  Future<void> getImagePost() async{
   final fileImagePost= await picker.pickImage(source: ImageSource.gallery);
   if(fileImagePost !=null){
     imagePickerPost=File(fileImagePost.path);
     emit(GetImagePostSuccessStates());
   }else{
     if (kDebugMode) {
       print('not selected');
     }
     emit(GetImagePostErrorStates());
   }

  }

  void createNewPost({
    required String name,
    required String uid,
    required String datetime,
     String? text,
    String? imagePost,
    int? likes,

  }){
    emit(CreateNewPostLoadingStates());
    ModelPost model=ModelPost(
        name: name,
        uid: uid,
        datetime: datetime,
        text: text ?? '',
        imageProfile:modelRegister!.imageProfile,
      imagePost: imagePost ?? '',
      likes: likes
    ) ;

    FirebaseFirestore
        .instance
        .collection('post')
        .add(model.toMap())
        .then((value) {

          if (kDebugMode) {
            print("uidddddpostttt ${value.id}");
          }
          emit(CreateNewPostSuccessStates());
    })
        .catchError((error){
          emit(CreateNewPostErrorStates());
    });


  }





  void uploadNewPostImage({
    required String name,
    required String uid,
    required String datetime,
     String? text,
     int? likes,

}){

    FirebaseStorage.instance.ref()
    .child(Uri.file('post/${imagePickerPost!.path}').pathSegments.last)
        .putFile(imagePickerPost!)
        .then((value) {
          value
              .ref
              .getDownloadURL()
              .then((value) {
            createNewPost(
                name: name,
                uid: uid,
                datetime: datetime,
                text: text,
                imagePost:value.toString(),
                likes: likes,

            );
          });

    })
    .catchError((error){
      emit(UploadNewPostImageErrorStates());
    });

  }


  void removePost(){
    imagePickerPost=null;
    emit(RemovePostSuccessStates());
  }


   /*
   List<ModelPost>post=[];
   List<String>uidPost=[];
   List<int>numberLikes=[];

   void getNewPost()
   {

    emit(EditProfileGetNewPostLoadingStates());
    FirebaseFirestore.instance
    .collection('post')
    .get()
        .then((values) {
      post=[];
          values.docs.forEach((element) {
            element.reference.collection('likes').get().then((value) {
              numberLikes.add(value.docs.length.toInt());
              uidPost.add(element.id);
              post.add(ModelPost.fromJson(element.data()));
            }).catchError((error){

            });

            emit(EditProfileGetNewPostSuccessStates());
          });
    })
        .catchError((error){
          emit(EditProfileGetNewPostErrorStates());
    });
   }*/

    int i=1;
   void likesPost({
    required String uidPost,


}){


    emit(LikesPostLoadingStates());
     FirebaseFirestore
         .instance
         .collection('post')
         .doc(uidPost)
         .collection('likes')
         .doc(modelRegister!.uid)
         .set({
       'like':true,
     }).then((value) {

       emit(LikesPostSuccessStates());
     })
         .catchError((error){

       emit(LikesPostPostErrorStates());


     });



   }

void removeLike({
    required String uidPost,
}){
     FirebaseFirestore.instance.collection('post').doc(uidPost)
         .collection('likes').doc(modelRegister!.uid).delete().then((value) {emit(RemoveLikesSuccessStates());}).catchError((error){emit(RemoveLikesErrorStates());});
       /*  .doc(uid).delete().then((value) {emit(RemoveLikesSuccessStates());}).catchError((error){emit(RemoveLikesErrorStates());});*/
}

//postrealtime
  List<ModelPost>post=[];
  List<String>uidPost=[];
  Map<String,int>numberLikess={};

  void getNewPost(context) {
      emit(EditProfileGetNewPostLoadingStates());
      //numberLikess=[];



      FirebaseFirestore
          .instance
          .collection('post')
          .orderBy('datetime')
          .snapshots()
          .listen((event) {
        post=[];
        uidPost=[];
         numberLikess={};
        // numberLikess=[];
        //  event.docs.forEach((element)
        for (var element in event.docs) {
          post.add(ModelPost.fromJson(element.data()));
          uidPost.add(element.id);
          element.reference.collection('likes').snapshots().listen((events) {

              // numberLikess.removeRange(0, (numberLikess.length/2).toInt() );
              numberLikess.addAll({
                '${element.id}':events.docs.length.toInt(),
              });

            }
          );




        }

        emit(EditProfileGetNewPostSuccessStates());
      });

      if (kDebugMode) {
        print("likessss  $numberLikess");
      }
      if (kDebugMode) {
        print("post  $post");
      }
      if (kDebugMode) {
        print("uidPost  $uidPost");
      }

  }











//chat

  List<RegisterModel>userAll=[] ;
void getUserAll(){
  emit(GetUserAllLoadingStates());
  userAll=[];
  FirebaseFirestore
      .instance
      .collection('users')
      .get()
      .then((value) {
        for (var element in value.docs) {
          if(element.data()['uid']!= modelRegister!.uid){
            userAll.add(RegisterModel.fromJson(element.data()));
            emit(GetUserAllSuccessStates());
          }

        }
  })
      .catchError((error){
        emit(GetUserAllErrorStates());
  });
}


//chatsDetails



void sendChat({
    required String reserve,
    required String datetime,
     String? text,
    String? image,
}){
  emit(SendChatLoadingStates());
  ModelChat modelChats=ModelChat(
      sender: modelRegister!.uid,
      reserve: reserve,
      datetime: datetime,
      text: text ?? '',
      image: image ?? '',
  );
  FirebaseFirestore
      .instance
      .collection('users')
      .doc(modelRegister!.uid)
      .collection('chat')
      .doc(reserve)
      .collection('message')
      .add(modelChats.toMap())
      .then((value) {
        emit(SendChatSuccessStates());
  })
      .catchError((error){
    emit(SendChatErrorStates());
  });
  FirebaseFirestore
      .instance
      .collection('users')
      .doc(reserve)
      .collection('chat')
      .doc(modelRegister!.uid)
      .collection('message')
      .add(modelChats.toMap())
      .then((value) {
    emit(SendChatSuccessStates());
  })
      .catchError((error){
    emit(SendChatErrorStates());
  });


}


  List<ModelChat>chatList=[];
void getChat({
  required String reserve,
}){

  FirebaseFirestore
      .instance
      .collection('users')
      .doc(modelRegister!.uid)
      .collection('chat')
      .doc(reserve)
      .collection('message')
      .orderBy('datetime')
      .snapshots()
      .listen((event) {
        chatList=[];
        for (var element in event.docs) {
          chatList.add(ModelChat.fromJson(element.data()));

        }
        emit(GetChatSuccessStates());
  });

}

File? imageChatPicker;
  Future<void> imagePickerChat() async{
  final fileImageChat= await picker.pickImage(source: ImageSource.gallery);
  if(fileImageChat !=null){
    imageChatPicker=File(fileImageChat.path);
    emit(ImagePickerChatSuccessStates());
  }else{
    if (kDebugMode) {
      print('not selected');
    }
    emit(ImagePickerChatErrorStates());
  }

}


void sendImageChat({
  required String reserve,
  required String datetime,
   String?  text,
  String? image,
}){
  //emit(SendImageChatLoadingStates());
  FirebaseStorage
      .instance
      .ref()
      .child(Uri.file('imageCath ${imageChatPicker!.path}').pathSegments.last)
      .putFile(File(imageChatPicker!.path))
      .then((value){
        value
            .ref
            .getDownloadURL()
            .then((value) {

          ModelChat model =ModelChat(
              sender: modelRegister!.uid,
              reserve: reserve,
              datetime: datetime,
              text:  text ?? '',
              image:value.toString() ?? '',
          );
          FirebaseFirestore
              .instance
              .collection('users')
              .doc(modelRegister!.uid)
              .collection('chat')
              .doc(reserve)
              .collection('message')
              .add(model.toMap())
              .then((value) {
           // emit(SendImageChatSuccessStates());
          })
              .catchError((error){
            emit(SendImageChatErrorStates());
          });

          FirebaseFirestore
              .instance
              .collection('users')
              .doc(reserve)
              .collection('chat')
              .doc(modelRegister!.uid)
              .collection('message')
              .add(model.toMap())
              .then((value) {
            emit(SendImageChatSuccessStates());
          })
              .catchError((error){
            emit(SendImageChatErrorStates());
          });

        }).catchError((error){
          emit(SendImageChatErrorStates());
        });

  });



}


}

//caths ++image




