import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shopapp/model/CategoriesModel/categire_model.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';

class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(
      listener: (context,ShopAppState){

      },
      builder: (context,ShopAppState){
        var cubit=ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.categoreisModel!=null,
            builder: (conetxt)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>BuildCatgoriesScreenItem(cubit.categoreisModel!.dataCategoreis!.data[index]),
                        separatorBuilder: (context,index)=>SizedBox(
                          height:20 ,
                        ),
                        itemCount: cubit.categoreisModel!.dataCategoreis!.data.length),
                  )
                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }
  Widget BuildCatgoriesScreenItem(DataModel model)=>Container(
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadiusDirectional.circular(20)
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        Image(
            height: 150,
            width: 150,
            image: NetworkImage(
                '${model.image}'
            )),
        SizedBox(
          width: 10,
        ),
        Text(
          '${model.name}'
              ,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,

          ),
        ),
        Spacer(

        ),
        Icon(
          Icons.navigate_next
        )

      ],
    ),
  );

}