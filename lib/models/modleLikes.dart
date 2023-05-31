// ignore_for_file: file_names
class ModelLikes{
  late final String like;

  // late final  String? image;


  ModelLikes({
    required this.like,

    // this.image,
  });

  ModelLikes.fromJson(Map<String,dynamic>json){
    like=json['like'];


  }
  Map<String,dynamic>toMap(){

    return{
      'like':like,


    };
  }

}