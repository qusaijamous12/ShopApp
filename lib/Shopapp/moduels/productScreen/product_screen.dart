import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Shopapp/model/homeModel/home_model.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';

import '../../model/CategoriesModel/categire_model.dart';

class ProductsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(
      listener: (context,ShopAppState){
        if(ShopAppState is AddOrChangeFavoritesSuccessState){
          if(!ShopAppState.status!){
            Fluttertoast.showToast(
                msg: "Not Authorized",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }
        }
        if(ShopAppState is AddOrChangeFavoritesErrorState){
          if(!ShopAppState.status!){
            Fluttertoast.showToast(
                msg: "Not Authorized",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }
        }

      },
      builder: (context,ShopAppState){
        var cubit=ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeDataModel!=null && cubit.categoreisModel!=null,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: cubit.homeDataModel!.data!.banners.map((e) =>
                          Image(image: NetworkImage(
                              '${e.image}'
                          )) ).toList(),
                      options:CarouselOptions(
                          height: 250,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1 // we use it to solve the problem of images that occuer when we dont use it try to put insted of 1 0.4 and you will see the problem
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                       Container(
                         height: 140,
                         child: ListView.separated(
                           physics: BouncingScrollPhysics(),
                           scrollDirection: Axis.horizontal,
                             itemBuilder: (context,index)=>BuildCategoriesItem(cubit.categoreisModel!.dataCategoreis!.data[index]),
                             separatorBuilder: (context,index)=>SizedBox(
                               width: 15,
                             ),
                             itemCount: cubit.categoreisModel!.dataCategoreis!.data.length),
                 ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'New Products',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index)=>BuildProductItem(cubit.homeDataModel!.data!.products[index],context),
                            separatorBuilder: (context,index)=>SizedBox(
                              height: 15,
                            ),
                            itemCount: cubit.homeDataModel!.data!.products.length),
                      ],
                    ),
                  )


                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }
  Widget BuildProductItem(Products products,context)=>Container(

    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(20),
      color: Colors.grey[200],

    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Image(
                height: 170,
                width: 170,
                fit: BoxFit.cover,
                image:NetworkImage('${products.image}') ),
            if(products.discount!=0)
              Container(
                color: Colors.red,
                child: Text(
                  'Discount',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )

          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 170,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${products.name}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize:18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'Price : ${products.price}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                if(products.discount!=0)
                Text(
                  'Old Price : ${products.old_price}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16
                  ),

                ),
              ],
            ),
          ),
        ),
        Container(
          height: 170,
          alignment: AlignmentDirectional.bottomEnd,
          child: IconButton(
              onPressed: (){
                ShopAppCubit.get(context).AddOrChangeFavorate(products.id!);
                print(products.id);
              }
              , icon: CircleAvatar(
            radius: 25,
                backgroundColor: ShopAppCubit.get(context).favorate[products.id]?Colors.red:Colors.grey,
                child: Icon(
                Icons.favorite_border
          ),
              )),
        )
      ],
    ),
  );
  Widget BuildCategoriesItem(DataModel model)=> Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
              height: 130,
              width: 130,
              image: NetworkImage(
                  '${model.image}'
              )),
          Container(
            color: Colors.black.withOpacity(0.9),
            width: 130,

            child: Text(
              '${model.name}',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),

            ),
          )
        ],
      )

    ],
  );



}