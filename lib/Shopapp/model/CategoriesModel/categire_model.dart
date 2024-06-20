class CategoreisModel{
  bool ?status;
  DataCategoreis ?dataCategoreis;
  CategoreisModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    dataCategoreis=DataCategoreis.fromJson(json['data']);
  }

}
class DataCategoreis{
  List<DataModel> data=[];
  DataCategoreis.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel{
  int ?id;
  String ?image;
  String ?name;
  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
    name=json['name'];
  }



}