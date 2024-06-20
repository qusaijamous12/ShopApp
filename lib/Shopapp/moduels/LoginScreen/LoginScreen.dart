import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/Shared/Constants/constants.dart';
import 'package:shopapp/Shopapp/moduels/LoginScreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/LoginScreen/cubit/state.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/homescreen.dart';
import 'package:shopapp/Shopapp/moduels/registerscreen/register_Screen.dart';

class LoginShopScreen extends StatelessWidget{
  var EmailContgroller=TextEditingController();
  var PasswordCotroller=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context)=>LoginCubit(),
     child: BlocConsumer<LoginCubit,LoginState>(
       listener: (context,LoginState){
         if(LoginState is LoginSuccessState){
           if(LoginState.message==true){
             token=LoginState.tokenn;

             Fluttertoast.showToast(
                 msg: "Login done successfully",
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.BOTTOM,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.red,
                 textColor: Colors.white,
                 fontSize: 16.0
             );
             NavigateAndFinish(context, HomeShopScreen());
           }


         }
         else if(LoginState is LoginErrorState){
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
       builder: (context,LoginState){
         var cubit=LoginCubit.get(context);
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
                           condition: LoginState is !LoadingLoginState,
                           builder: (context)=> BuildDefaultButton(
                               onpress: (){
                                 if(formKey.currentState!.validate()){
                                   cubit.LoginPostData(
                                     context,
                                       email: EmailContgroller.text,

                                       password: PasswordCotroller.text);

                                 }
                               },
                               text: 'Login',
                               color: Colors.red),
                           fallback: (context)=>Center(child: CircularProgressIndicator())),

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
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterShopScreen()));

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
       },
     ),
   );
  }

}