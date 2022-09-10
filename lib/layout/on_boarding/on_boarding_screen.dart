import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingItems{
  String image;
  String title;
  String body;
  BoardingItems(this.title,this.body,this.image);
}
bool nav=false;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingItems> items=[
    BoardingItems(
        'title 1',
        'boarding body1',
        'assets/images/onboard2.webp'),
    BoardingItems(
        'title 2',
        'boarding body2',
        'assets/images/onboard3.jpg'),
    BoardingItems(
        'title 3',
        'boarding body3',
        'assets/images/onboard4.jpg'),
  ];
  var controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildTextInkWell(
              text: 'SKIP',
              tap: (){
                   submit();
              },
              fontSize:20)
      ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Expanded(
             child: PageView.builder(
               controller: controller,
               physics: BouncingScrollPhysics(),
                itemCount: items.length,
                 itemBuilder: (context,index)=> buildOnBoard(items[index]),
                 onPageChanged: (index){
                   if(index==items.length-1)
                     nav=true;
                   else
                     nav=false;

                 }
              ),
           ),

            Row(
              children: [
                SmoothPageIndicator(
                    controller: controller,  // PageController
                    count:  items.length,
                    effect:  ExpandingDotsEffect(
                      dotHeight: 15,
                      expansionFactor:3,
                      dotWidth: 15,
                      dotColor: baseColor2,
                      activeDotColor: Colors.grey
                    ),  // your preferred effect

                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios,
                    color:baseColor2,),
                  onPressed:(){
                    if(nav){

                      submit();
                    }else{
                      controller.nextPage(
                          duration: Duration(microseconds: 500),
                          curve: Curves.easeInCirc);
                    }

                  },

                )

              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildOnBoard(BoardingItems boardItems) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
          Expanded(
            flex: 2,
            child: Image.asset('${boardItems.image}',
            ),
          ),
        SizedBox(height: 30,),
        Text('${boardItems.title}',
            style:TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            )),
        SizedBox(height: 15,),
        Text('${boardItems.body}',
          style: TextStyle(
              fontSize: 18
          ),
        ),
      ],
    );
  }
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true)
        .then((value) {
          if(value){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder:(context)=> LoginScreen()),
                    (route) => false);
          }

    });

  }
}