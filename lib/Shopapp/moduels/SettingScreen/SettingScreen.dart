import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/CasheHelper/cashe_helper.dart';
import 'package:shopapp/Shared/Constants/constants.dart';
import 'package:shopapp/Shopapp/moduels/LoginScreen/LoginScreen.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/state.dart';

class SettingScreen extends StatelessWidget{
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppState>(
      listener: (context,ShopAppState){

      },
      builder: (context,ShopAppState){
        var cubit=ShopAppCubit.get(context);
        emailController.text=cubit.userProfile!.data!.email!;
        nameController.text=cubit.userProfile!.data!.name!;
        phoneController.text=cubit.userProfile!.data!.phone!;
        return ConditionalBuilder(
            condition: cubit.userProfile!=null,
            builder: (context)=> Padding (
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BuildDefaultTextFormField(
                      Text: 'Name',
                      prefixIcon: Icons.perm_identity,
                      ObsecureText: false,
                      textInputType: TextInputType.text,
                      controller: nameController,
                      validate: (String ?value){
                        if(value==null || value.isEmpty){
                          return ' please enter the value';
                        }
                        else
                          return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  BuildDefaultTextFormField(
                      Text: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                      ObsecureText: false,
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      validate: (String ?value){
                        if(value==null || value.isEmpty){
                          return ' please enter the value';
                        }
                        else
                          return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  BuildDefaultTextFormField(
                      Text: 'Phone',
                      prefixIcon: Icons.phone,
                      ObsecureText: false,
                      textInputType: TextInputType.emailAddress,
                      controller: phoneController,
                      validate: (String ?value){
                        if(value==null || value.isEmpty){
                          return ' please enter the value';
                        }
                        else
                          return null;
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  BuildDefaultButton(
                      onpress: (){
                        CasheHelper.DeleteData(key: 'token');
                        cubit.currentIndex=0;
                        NavigateAndFinish(context, LoginShopScreen());

                      },
                      text: 'LOGOUT',
                      color: Colors.red),
                  SizedBox(
                    height: 20,
                  ),
                  ConditionalBuilder(
                      condition: ShopAppState is !LoadingUpdateProfile,
                      builder: (context)=> BuildDefaultButton(
                          onpress: (){
                            ShopAppCubit.get(context).UpdateProfileData(name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);

                          },
                          text: 'UPDATE',
                          color: Colors.red),
                      fallback: (context)=>Center(child: CircularProgressIndicator()))



                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }

}