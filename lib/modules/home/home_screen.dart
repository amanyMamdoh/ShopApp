
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,ShopHomeStates>(
      listener:(Context,State){
        if(State is ChangeFavoriteModelSuccessState){
          if(LayoutCubit.get(context).favModel!.status== false){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${LayoutCubit.get(context).favModel!.message}'),
          ));
          }

        }
      },
      builder: (Context,State){
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => State is! ShopHomeLoadingState && State is! ShopCategoriesLoadingState
                              && LayoutCubit.get(context).catModel !=null&& LayoutCubit.get(context).homeM !=null,
          widgetBuilder: (BuildContext context) => ProductBuilder(LayoutCubit.get(context).homeM,
                                                         LayoutCubit.get(context).catModel,context),
          fallbackBuilder: (BuildContext context) =>CircularProgressIndicator(),
        );
      },
    );
  }

  Widget ProductBuilder(HomeModel? homeM,CategoriesModel? catModel,context) {
    return  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items:homeM!.data!.bannerList.map((e) =>
                  Image( image:NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )).toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse:false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1
              )
          ),
          SizedBox(height: 20,),
          Text('Categories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Container(
            height: 100,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=>BuildCategoryItem(catModel!.dataModel!.dataList[index]),
                separatorBuilder: (context,index)=>SizedBox(width: 10,),
                itemCount: catModel!.dataModel!.dataList.length),
          ),
          SizedBox(height: 20,),
          Text('New Products',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      //color: Colors.yellowAccent,
                      child: GridView.count(
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 2,
                        childAspectRatio: 1/1.55,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                            homeM.data!.productList.length,
                                (index) => BuildProductItem(homeM.data!.productList[index],context)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget BuildCategoryItem(Data? model){
    return Container(
      height: 100,
      width: 100,
      child: Stack(
          alignment: Alignment.center,
          children:[
            Image(image:
            NetworkImage('${model!.image}'),
              fit: BoxFit.cover,),
            Container(
              width: 100,
              height: 25,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Text('${model.name}',

                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
            )]
      ),
    );
  }
  Widget BuildProductItem(Products? model,context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        boxShadow:[ BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0
        )],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),


      ),

      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [

                Image( image:NetworkImage('${model!.image}'),
                  width: double.infinity,
                  // fit: BoxFit.cover,
                  height: 200,
                ),
                Container(
                    color: Colors.red,
                    child:Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('DISCOUNT ',
                        style: TextStyle(fontSize: 16,color: Colors.white),),
                    )
                ),
              ],
            ),

            Text('${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  height: 1.2,
                  fontSize: 14
              ),
            ),
            Row(
                children: [
                  Text('${model.price.round()}',
                    style: TextStyle(
                        fontSize: 12,
                        color: baseColor
                    ),
                  ),
                  SizedBox(width: 20,),
                  if(model.discount != 0)
                    Text('${model.old_price.round()}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:LayoutCubit.get(context).favorite[model.id!]! ? baseColor:Colors.grey,
                    child: Center(
                      child: IconButton(
                          onPressed:(){
                            LayoutCubit.get(context).changeFavorite(model.id!);
                          },
                          icon: Icon(Icons.favorite_outline,color: Colors.white,)),
                    ),
                  )



                ]
            ),



          ],
        ),
      ),
    ) ;
  }
}

/*
 buildTextInkWell(
    text: 'sign out',
        tap: () {
          print('hi');
          CacheHelper.removeData(key: 'token').
          then((value) {
            if (value) {
              print(value);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()),
                      (route) => false);
            }
          });
        }
        /**/,
        fontSize: 20
    ),

* */