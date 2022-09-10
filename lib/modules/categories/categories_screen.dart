import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<LayoutCubit,ShopHomeStates>(
        listener:(Context,State){},
        builder: (Context,State){
          return ListView.separated(
          itemBuilder: (Context,index)=>BuildItems(LayoutCubit.get(context).catModel!.dataModel!.dataList[index]),
          separatorBuilder:(Context,index)=>
                  Container(height: 1,color: Colors.grey,width: double.infinity,) ,
    itemCount:LayoutCubit.get(context).catModel!.dataModel!.dataList.length );
    }

    );
}

  Widget BuildItems(Data dataList) {
   return  Padding(
     padding: EdgeInsets.all(10),
     child: Row(
       children: [
         Container(
           height: 100,
           width: 100,
           child: Image(image: NetworkImage('${dataList.image}'),
         ),)
         ,SizedBox(width: 20,),
         Text('${dataList.name}'),
         Spacer(),
         IconButton(onPressed:()=>print('hi'), icon: Icon(Icons.arrow_forward_ios))
       ],
     ),
   );
  }
  }

