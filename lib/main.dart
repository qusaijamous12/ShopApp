import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Shared/CasheHelper/cashe_helper.dart';
import 'package:shopapp/Shared/Diohelper/dioheloer.dart';
import 'package:shopapp/Shared/Themes/theme.dart';
import 'package:shopapp/Shopapp/moduels/LoginScreen/LoginScreen.dart';
import 'package:shopapp/Shopapp/moduels/Onboard/onBoard_Screen.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/cubit/cubit.dart';
import 'package:shopapp/Shopapp/moduels/homescreen/homescreen.dart';
import 'package:shopapp/SocialApp/homeSocailScreen.dart';

import 'Shared/Constants/constants.dart';
import 'Shared/observer/observer.dart';
import 'SocialApp/loginsocialApp/login_social.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  dynamic onBoard=CasheHelper.GetData(key:'onBoard');
  token=CasheHelper.GetData(key:'token');
  print(onBoard);
  print(token);


  Widget ?StartScreen;
  if(onBoard==true&&onBoard!=null){
    if(token!=null){
      StartScreen=HomeShopScreen();
    }
    else
      {
        StartScreen=LoginShopScreen();
      }

  }
  else{
    StartScreen=OnBoardScreen();
  }

  runApp(MyApp(StartScreen));
}
class MyApp extends StatelessWidget{

  Widget ?widget;
  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>ShopAppCubit()..GetData()..GetCategoriesData()..GetFavorateData()..GetProfileData()),
      ],
      child: MaterialApp(
        home: SocialLoginScreen(),
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,

      ),
    );

  }

}

