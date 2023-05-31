
class RegisterModel{
  late final String name;
  late final String email;
  late final String password;
  late final String uid;
  late final String phone;
   late final String? bio;
  late final  String? imageProfile;
   late final String? imageCover;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.phone,
    this.bio,
    this.imageCover,
    this.imageProfile,
});

  RegisterModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    password=json['password'];
    uid=json['uid'];
    phone=json['phone'];
    bio=json['bio'];
    imageCover=json['imageCover'];
    imageProfile=json['imageProfile'];
  }
  Map<String,dynamic>toMap(){

    return{
      'name':name,
      'email':email,
      'password':password,
      'uid':uid,
      'phone':phone,
      'bio':bio,
      'imageCover':imageCover,
      'imageProfile':imageProfile,
    };
  }

}