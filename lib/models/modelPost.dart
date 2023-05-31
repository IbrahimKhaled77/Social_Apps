
// ignore_for_file: file_names

class ModelPost{
  late final String name;
  late final String uid;
  late final int? likes;
  late final String datetime;
  late final  String? imageProfile;
  late final  String? imagePost;
  late final String? text;


  ModelPost({
    required this.name,
    required this.uid,
    required this.datetime,
    this.imageProfile,
    this.text,
    this.imagePost,
    this.likes,
  });

  ModelPost.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uid=json['uid'];
    datetime=json['datetime'];
    text=json['text'];
    imagePost=json['imagePost'];
    imageProfile=json['imageProfile'];
    likes=json['likes'];
  }
  Map<String,dynamic>toMap(){

    return{
      'name':name,
      'imagePost':imagePost,
      'imageProfile':imageProfile,
      'uid':uid,
      'datetime':datetime,
      'text':text,
      'likes':likes,
    };
  }

}