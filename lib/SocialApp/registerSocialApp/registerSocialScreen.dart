import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/SocialApp/registerSocialApp/cubit/cubit.dart';
import 'package:shopapp/SocialApp/registerSocialApp/cubit/state.dart';

import '../../Shared/Constants/constants.dart';

class RegisterSocialScreen extends StatelessWidget{
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passswordController=TextEditingController();
  var phoneController=TextEditingController();
  var fromkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterSocialCubit(),
      child: BlocConsumer<RegisterSocialCubit,RegisterSocailState>(
        listener: (context,RegisterSocailState){
          if(RegisterSocailState is CreateAccountSuccesState){
                Fluttertoast.showToast(
                    msg: "Create Account successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
          }
          else if(RegisterSocailState is CreateAccountErrorState){
                Fluttertoast.showToast(
                    msg: "Error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
          }

        },
        builder: (context,RegisterSocailState){
          var cubit=RegisterSocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);

                },
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.red,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: fromkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BuildDefaultTextFormField(
                            Text: 'Name',
                            prefixIcon: Icons.person,
                            ObsecureText: false,
                            textInputType: TextInputType.text,
                            controller: nameController,
                            validate: (String ?value){
                              if(value==null || value.isEmpty){
                                return ' please enter value';
                              }
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
                                return ' please enter value';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        BuildDefaultTextFormField(
                            Text: 'Password',
                            prefixIcon: Icons.lock_outline,
                            ObsecureText: false,
                            textInputType: TextInputType.text,
                            controller: passswordController,
                            validate: (String ?value){
                              if(value==null || value.isEmpty){
                                return ' please enter value';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        BuildDefaultTextFormField(
                            Text: 'Phone',
                            prefixIcon: Icons.phone,
                            ObsecureText: false,
                            textInputType: TextInputType.phone,
                            controller: phoneController,
                            validate: (String ?value){
                              if(value==null || value.isEmpty){
                                return ' please enter value';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition:RegisterSocailState is !LoadingCreateAccount ,
                          builder:(context)=>BuildDefaultButton(
                              onpress: (){
                                if(fromkey.currentState!.validate()){
                                  cubit.CreateAccount(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passswordController.text);


                                }


                              },
                              text: 'REGISTER',
                              color: Colors.red) ,
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),


          );
        },
      ),
    );
  }

}