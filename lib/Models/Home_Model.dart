class HomeModel{
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']) ;

  }
}
class HomeDataModel{
  List<Banner>banners=[];
  List<product>products=[];

  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element){
      banners.add(Banner.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(product.fromJson(element));
    });

    

  }
}
class Banner{
  int id;
  String image;

  Banner.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];


  }


}
class product{
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  bool in_favorites;
  bool in_cart;


  product.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];

  }




}