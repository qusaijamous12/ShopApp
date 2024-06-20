class UpdateModel{
    bool ?status;
    String ?message;
    UpdateModel.fromJson(Map<String,dynamic> json){
      status=json['status'];
      message=json['message'];
    }
}