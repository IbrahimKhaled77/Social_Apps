// ignore_for_file: file_names
class ModelChat{
  late final String sender;
  late final String reserve;
  late final String datetime;
  late final  String? text;
  late final  String? image;


  ModelChat({
    required this.sender,
    required this.reserve,
    required this.datetime,
    this.text,
    this.image,
  });

  ModelChat.fromJson(Map<String,dynamic>json){
    sender=json['sender'];
    reserve=json['reserve'];
    datetime=json['datetime'];
    text=json['text'];
    image=json['image'];

  }
  Map<String,dynamic>toMap(){

    return{
      'sender':sender,
      'reserve':reserve,
      'datetime':datetime,
      'text':text,
      'image':image,
    };
  }

}