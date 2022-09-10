
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/search/search_screen.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,ShopHomeStates>(
      listener: (BuildContext context,  state) {},
      builder: (BuildContext context, state) {
        var cubit=LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('title'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>searchScreen()),
                  );
                },

              )
            ],
          ),
         body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

              currentIndex: cubit.currentIndex,
              items: LayoutCubit.get(context).items,
            onTap:(index)=> cubit.changeNavBar(index)


          )
      );
      },


    );
  }


}
