import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/models/favorites_model/favorite_items_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class favoriteScreen extends StatelessWidget {
  const favoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<LayoutCubit,ShopHomeStates>(
        listener: (BuildContext context,  state) {},
    builder: (BuildContext context, state) {
   // var cubit=LayoutCubit.get(context);
     return ConditionalBuilder(
       condition: State is! GetFavoriteLoadingState,
       builder: (BuildContext context) => ListView.separated(
         itemBuilder:(context,index)=> buildFavItem(LayoutCubit.get(context).favItemModel!.data!.data![index],context),
         itemCount: LayoutCubit.get(context).favItemModel!.data!.data!.length,
         separatorBuilder: (BuildContext context, int index) =>Container(height: 1,width: double.infinity,color: Colors.grey,),

       ), fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(),),

     );
      }
     );
  }
  Widget buildFavItem(Data? data, context){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 120,
        width: double.infinity,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [

                Image( image:NetworkImage('${data!.product!.image}'),
                  width: 120,
                  fit: BoxFit.cover,
                  height: 120,


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
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text('${data.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.2,
                        fontSize: 14
                    ),
                  ),
                  Spacer(),
                  Row(
                      children: [
                        Text('${data.product!.price!.round()}',
                          style: TextStyle(
                              fontSize: 12,
                              color: baseColor
                          ),
                        ),
                        SizedBox(width: 20,),
                        if(data.product!.discount! != 0)
                          Text('${data.product!.oldPrice!.round()}',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 12
                            ),
                          ),
                        Spacer(),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:LayoutCubit.get(context).favorite[data.product!.id!]! ? baseColor:Colors.grey,
                          child: Center(
                            child: IconButton(
                                onPressed:(){
                                  LayoutCubit.get(context).changeFavorite(data.product!.id!);
                                },
                                icon: Icon(Icons.favorite_outline,color: Colors.white,)),
                          ),
                        )



                      ]
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
