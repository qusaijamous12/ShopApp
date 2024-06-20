class SerachModel{
  bool ?status;
  SerachData ?serachData;
  SerachModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    serachData=SerachData.fromJson(json['data']);
  }



}
class SerachData{
  List<Data2> data=[];
  SerachData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(Data2.fromJson(element));

    });
  }

}
class Data2{
  int ?id;
  dynamic price;
  String ?image;
  String ?name;
  Data2.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    image=json['image'];
    name=json['name'];
  }

}