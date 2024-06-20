import 'package:bloc/bloc.dart';
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

import 'Shared/Constants/constants.dart';
import 'Shared/observer/observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
        home: widget,
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,

      ),
    );

  }

}

