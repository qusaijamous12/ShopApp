class FavorateData{
  bool ?status;
  DataFavorate2 ?dataFavorate2;
  FavorateData.fromJson(Map<String,dynamic> json){
    status=json['status'];
    dataFavorate2=DataFavorate2.fromJson(json['data']);
  }


}
class DataFavorate2{

  List<Data3> data3=[];
  DataFavorate2.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data3.add(Data3.fromJson(element));
    });
  }


}
class Data3{
ProductData4 ?productData4;
Data3.fromJson(Map<String,dynamic> json){
  productData4=ProductData4.fromJson(json['product']);
}


}
class ProductData4{
  int ?id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String ?image;
  String ?name;
  ProductData4.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];


  }
}

