class FavorateModel{
  bool ?status;
  String ?message;
  FavorateModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}