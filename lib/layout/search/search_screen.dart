import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/search/cubit/cubit.dart';
import 'package:shop_app/layout/search/cubit/state.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class searchScreen extends StatelessWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,ShopHomeSearchState>(
          listener: (BuildContext context,  state) {
            if(state is SearchSuccessState)
              print('hhhhhlistener');
          },
          builder: (BuildContext context, state) {
            if(state is SearchSuccessState)
              print('hhhhhbuild');
        return Scaffold(
          appBar: AppBar(),
          body:Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200
                  ),
                  width: double.infinity,
                  height: 70,
                  // color: Colors.black,
                  child:  TextFormField(
                      controller: searchController,
                      validator:(value){
                        if(value!.isEmpty)
                          return " empty input,you should enter data" ;
                        else
                          return null;
                      },
                      keyboardType: TextInputType.text,
                      onFieldSubmitted:(String v){
                        print(v);
                        SearchCubit.get(context).Search(text: v);
                      },
                      decoration:  InputDecoration    (
                        labelText: 'Search text',
                        prefixIcon:Icon(Icons.search,
                          color: baseColor2,),
                        border: InputBorder.none,

                      )
                  )
              ),
            // if(State is SearchSuccessState)
              ConditionalBuilder(
                condition:SearchCubit.get(context).sModel != null ,
                builder:(context)=> Expanded(
                   child: ListView.separated(
                      itemBuilder:(context,index)=>//Container(width: 100,height: 100,color: Colors.black,),
           buildProductItemm(SearchCubit.get(context).sModel!.data!.productl![index],context),
                      separatorBuilder: (context,index)=>Container(
                          color: Colors.grey,height: 1,width: double.infinity),
                      itemCount:SearchCubit.get(context).sModel!.data!.productl!.length
                  ),
                ), fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(),),
              )
            ],
          )
        );

      }
      ),
    );
  }
  Widget buildProductItemm( data , context){
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

                Image( image:NetworkImage('${data!.image}'),
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

                  Text('${data!.name}',
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
                        Text('${data.price!.round()}',
                          style: TextStyle(
                              fontSize: 12,
                              color: baseColor
                          ),
                        ),
                        SizedBox(width: 20,),
                        //if(data.product!.discount! != 0)
                        /*  Text('${data.product!.oldPrice!.round()}',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12
                          ),
                        ),*/
                        Spacer(),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:LayoutCubit.get(context).favorite[data.id!]! ? baseColor:Colors.grey,
                          child: Center(
                            child: IconButton(
                                onPressed:(){
                                  LayoutCubit.get(context).changeFavorite(data.id!);
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
