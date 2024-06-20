import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/Constants/constants.dart';
import 'package:shopapp/Shopapp/model/serachModel/serach_model.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';

class SerachScreen extends StatelessWidget{
  var serachController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(
      listener: (context,ShopAppState){

      },
      builder: (context,ShopAppState){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);

              },
              icon: Icon(
                Icons.navigate_before_outlined,
                color: Colors.red,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  BuildDefaultTextFormField(
                      Text: 'Serach',
                      onchange: (String ?value){
                        ShopAppCubit.get(context).SerachItem(value!);

                      },
                      prefixIcon: Icons.search_rounded,
                      ObsecureText: false,
                      textInputType: TextInputType.text,
                      controller: serachController,
                      validate: (String ?value){
                        if(value==null || value.isEmpty){
                          return "please enter value";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                      condition: ShopAppCubit.get(context).serachModel!=null,
                      builder: (context)=>ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          itemBuilder: (context,index)=>BuildSerachItem(ShopAppCubit.get(context).serachModel!.serachData!.data[index]),
                          separatorBuilder: (context,index)=>SizedBox(
                            height: 20,
                          ),
                          itemCount: ShopAppCubit.get(context).serachModel!.serachData!.data.length),
                      fallback: (context)=>Center(child: CircularProgressIndicator()))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget BuildSerachItem(Data2 model)=>Row(
    children: [
      Image(
        height: 150,
          width: 150,
          fit: BoxFit.cover,
          image: NetworkImage(
            '${model.image}'
          ),
      ),
      SizedBox(
        width: 30,
      ),
      Expanded(
        child: Text(
          '${model.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      )


    ],
  );

}