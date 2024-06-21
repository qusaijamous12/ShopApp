import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/SocialApp/homeSocailScreen.dart';
import 'package:shopapp/SocialApp/loginsocialApp/cubit/cubit.dart';
import 'package:shopapp/SocialApp/loginsocialApp/cubit/state.dart';

import '../../Shared/Constants/constants.dart';
import '../registerSocialApp/registerSocialScreen.dart';

class SocialLoginScreen extends StatelessWidget{
  var EmailContgroller=TextEditingController();
  var PasswordCotroller=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginSocailCubit(),
      child: BlocConsumer<LoginSocailCubit,LoginSocialState>(
        listener: (context,LoginSocialState){
          if(LoginSocialState is LoginSuccessState){
            Fluttertoast.showToast(
                msg: "Login Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            NavigateAndFinish(context, HomeSocialScreen());
          }else if(LoginSocialState is LoginErrorState){
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
        builder: (context,LoginSocialState){
          var cubit=LoginSocailCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 40
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to see our Hot offers',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 20,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BuildDefaultTextFormField(
                            Text: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            ObsecureText: false,
                            textInputType: TextInputType.emailAddress,
                            controller: EmailContgroller,
                            validate: (String ?text){
                              if(text==null || text.isEmpty){
                                return 'Please Enter Your Email';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        BuildDefaultTextFormField(
                            Text: 'Password',
                            prefixIcon: Icons.lock_outline,
                            ObsecureText: cubit.isSeucuerText,
                            textInputType: TextInputType.emailAddress,
                            controller: PasswordCotroller,
                            suffixIxon: cubit.icon,
                            onpressIconButton: (){
                              cubit.ChnageIcon();
                            },
                            validate: (String ?text){
                              if(text==null || text.isEmpty){
                                return 'Please Enter Your Password';
                              }
                              return null;
                            }),
                        SizedBox(
                          height:20 ,
                        ),
                       ConditionalBuilder(
                           condition:LoginSocialState is ! LoadingLoginState ,
                           builder: (context)=>BuildDefaultButton(
                               onpress: (){
                                 cubit.LoginSocialAccount(context,
                                     email: EmailContgroller.text,
                                     password: PasswordCotroller.text);

                               },
                               text: 'LOGIN',
                               color: Colors.red),
                           fallback: (context)=>Center(child: CircularProgressIndicator()))
                        ,

                        SizedBox(
                          height: 40,
                        ),

                        Row(
                          children: [
                            Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            TextDefaultButton('Register', () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterSocialScreen()));

                            })
                          ],
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        }
      ),
    );

  }

}