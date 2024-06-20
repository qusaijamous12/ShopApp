import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shopapp/model/getfavorate/getfavorate.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';

class FavorateScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(
      listener: (context,ShopAppState){

      },
      builder: (context,ShopAppState){
        return ConditionalBuilder(
            condition: ShopAppState is!LoadingGetFavorateData,
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>BuildFavoraiteItem(ShopAppCubit.get(context).favorateData!.dataFavorate2!.data3[index].productData4!,context),
                        separatorBuilder: (context,index)=>SizedBox(
                          height: 15,
                        ),
                        itemCount:ShopAppCubit.get(context).favorateData!.dataFavorate2!.data3.length ),
                  )
                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }


  Widget BuildFavoraiteItem(ProductData4 model,context)=>Container(

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
                image:NetworkImage('${model.image}') ),
              if(model.discount!=0)
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
                    '${model.name}',
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
                  'Price : ${model.price} ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                if(model.discount!=0)
                  Text(
                    'Old Price : ${model.old_price}',
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
                ShopAppCubit.get(context).AddOrChangeFavorate(model.id!);
               
              }
              , icon: CircleAvatar(
            radius: 25,
            backgroundColor: ShopAppCubit.get(context).favorate[model.id]?Colors.red:Colors.grey,
            child: Icon(
                Icons.favorite_border
            ),
          )),
        )
      ],
    ),
  );


}