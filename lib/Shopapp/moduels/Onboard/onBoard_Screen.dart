import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Shared/CasheHelper/cashe_helper.dart';
import 'package:shopapp/Shared/Constants/constants.dart';
import 'package:shopapp/Shopapp/moduels/LoginScreen/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ImageModel{
  String ?image;
  String ?title;
  String ?screen;
  ImageModel({this.image,this.screen,this.title});
}


class OnBoardScreen extends StatefulWidget{
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  List<ImageModel> ChangeScreen=[
   ImageModel(
     image: 'asset/image/shop1.png',
     title: 'Welcome in Our App',
     screen: 'Screen 1'
   ),
    ImageModel(
        image: 'asset/image/shop2.png',
        title: 'you will see the best offer',
        screen: 'Screen 2'
    ),
    ImageModel(
        image: 'asset/image/shop3.png',
        title: 'Enjoy in Our App',
        screen: 'Screen 3'
    )
  ];

  var PageViewController=PageController();

  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         TextDefaultButton(
             'Skip',
                 () {
               setState(() {
                 isLast=true;
                 CasheHelper.SaveData(data:isLast, key: 'onBoard');
                 NavigateAndFinish(context, LoginShopScreen());
               });
                 })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>BuildOnBoardScreen(ChangeScreen[index]),
                itemCount: ChangeScreen.length,
                onPageChanged: (index){
                  if(index==ChangeScreen.length-1){
                    print('last');
                    setState(() {
                      isLast=true;
                    });

                  }
                  else
                    {
                      print('not last');
                      isLast=false;
                    }
                },
                controller:PageViewController,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: PageViewController,
                  count: ChangeScreen.length,
                  effect:ExpandingDotsEffect(
                    spacing: 7,
                    activeDotColor: Colors.red,

                  ) ,
                ),
                Spacer(),
                FloatingActionButton(onPressed:(){
                  PageViewController.nextPage(
                      duration:Duration(
                        milliseconds: 1
                      ) ,
                    curve:Curves.fastEaseInToSlowEaseOut

                  );
                  if(isLast){
                    CasheHelper.SaveData(data: isLast, key: 'onBoard');
                    NavigateAndFinish(context, LoginShopScreen());
                  }

                },
                  child: Icon(
                      Icons.navigate_next
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget BuildOnBoardScreen(ImageModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage(
              '${model.image}'
          ),
          width: double.infinity,
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.only(
            bottom: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.title}',
              style:TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${model.screen}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 50,
            ),

          ],
        ),
      ),

    ],
  );
}