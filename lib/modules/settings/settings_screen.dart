import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/state.dart';
import 'package:shop_app/models/login_model/login.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class settingsScreen extends StatelessWidget {
  //const settingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LayoutCubit,ShopHomeStates>(
        listener: (BuildContext context,  state) {},
        builder: (BuildContext context, state) {
          var cubit=LayoutCubit.get(context).userModel;
          nameController.text=cubit!.data!.name! ;
          phoneController.text=cubit.data!.phone! ;
          emailController.text=cubit.data!.email! ;
          return ConditionalBuilder(
            condition: State is ! GetUserLoadingState,
            builder: (BuildContext context)=> 
                SingleChildScrollView(
                  child: Column(
              children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/icon.png',),
               //   backgroundImage: NetworkImage('${LayoutCubit.get(context).userModel!.data!.image}',),
                  ),

                  Form(
                     key:formKey,

                     child: Column(
                       children:[
                         if(State is UpdateUserLoadingState)
                           LinearProgressIndicator(),
                         Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                               decoration:  BoxDecoration(
                               color: Colors.grey.shade200,
                               borderRadius: BorderRadius.all(
                                 Radius.circular(20),
          )
          ),
                             height: 50,
                            width: double.infinity,
                             child: Padding(
                              padding: EdgeInsets.only(left: 20),
                                child: buildTextField(
                            controller: nameController,
                              type: TextInputType.text,
                            ic: Icons.title,
                             label: 'name',

          )
          ),
          ),

          ),SizedBox(height: 20,),
            Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration:  BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: buildTextField(
                          controller: emailController,
                          type: TextInputType.text,
                          ic: Icons.email,
                          label: 'email',

                        )
                    ),
                  ),
            ),
             SizedBox(height: 20,),
             Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration:  BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: buildTextField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          ic: Icons.phone,
                          label: 'phone',

                        )
                    ),
                  ),
            ),

                       ]
                     ),


          ),
                SizedBox(height: 40,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: buildButton(
                        press:(){
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
                    }, text: 'LOGOUT',
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                    child: buildButton(
                      press:(){
                           LayoutCubit.get(context).updateUserData(
                               name: nameController.text,
                               email: emailController.text,
                               phone: phoneController.text,
                              );
                          }, text: 'UPDATE'
                    ),
                  )
              ],
            ),
                ),
            fallback: (BuildContext context)=>Center(child: CircularProgressIndicator(),),

          );
    }
    );
  }

}
