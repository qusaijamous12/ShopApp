class SocailModel{
  String ?name;
  String ?email;
  String ?uId;
  String ?phone;

SocailModel({this.phone,
this.name,
this.email,
this.uId});

SocailModel.fromJson(Map<String,dynamic>json){
  name=json['name'];
  email=json['email'];
  uId=json['uId'];
  phone=json['phone'];


}

Map<String,dynamic> toMap(){
  return {
    'name':name,
    'email':email,
    'phone':phone,
    'uId':uId,
  };
}





}