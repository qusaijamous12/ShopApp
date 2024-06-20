import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shopapp/Shopapp/moduels/SerachScreen/serachscreen.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';

class HomeShopScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(
      listener: (context,ShopAppState){

      },
      builder: (context,ShopAppState){
        var cubit=ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Market',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize:30
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SerachScreen()));

                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
          body: ConditionalBuilder(
              condition: ShopAppCubit.get(context).homeDataModel!=null,
              builder: (context)=>cubit.ChangeScreen[cubit.currentIndex],
              fallback: (context)=>Center(child: CircularProgressIndicator())),
          bottomNavigationBar: Padding(
            padding:EdgeInsetsDirectional.all(12),
            child: GNav(
              padding: EdgeInsetsDirectional.all(12),
              activeColor: Colors.white,
              tabBackgroundColor: Colors.red,
              selectedIndex: cubit.currentIndex,
              onTabChange: (index){
                cubit.ChangeCurrentIndex(index);
              },
              gap: 4,

              tabs: [
                GButton(
                    icon:Icons.apps,
                  text: 'Products',
                ),
                GButton(
                  icon:Icons.category,
                  text: 'Category',
                ),
                GButton(
                  icon:Icons.favorite,
                  text: 'Favorite',
                ),
                GButton(
                  icon:Icons.settings,
                  text: 'Setting',
                )
              ],
            ),
          ),

        );
      },
    );
  }

}