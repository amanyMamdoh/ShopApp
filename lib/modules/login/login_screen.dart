import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/state.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child:BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (BuildContext context, state) {
          if(state is ShopLoginSuccessfulState){
            if(state.loginModel.status ==true){
              istoken=state.loginModel.data!.token!;
              print(state.loginModel.status);
              print(state.loginModel.data!.token!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${state.loginModel.message}'),
              ));
              CacheHelper.saveData(key: 'token',
                  value: state.loginModel.data!.token!).
              then((value) {
                istoken=state.loginModel.data!.token!;
                print(istoken);
                LayoutCubit.get(context).currentIndex=0;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder:(context)=> ShopLayout()),
                        (route) => false);
              } );
            }else{
              print(state.loginModel.message);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${state.loginModel.message}',
                ),
              )
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20,left: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Login',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4!.copyWith(color: Colors.black)
                            ),
                            SizedBox(height: 10,),
                            Text('login to brows our application',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!.copyWith(color: Colors.black),),
                            SizedBox(height: 20,),
                            buildTextField(
                              controller: emailController,
                              ic: Icons.email_rounded,
                              label: 'email',
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 20,),
                            buildTextField(
                                controller: passwordController,
                                ic: Icons.password_outlined,
                                label: 'password',
                                type: TextInputType.text,
                                suffix: ShopLoginCubit.get(context).changeVisiblity,
                                obsecure:ShopLoginCubit.get(context).ispassword ,
                                suffixPressd: (){
                                  ShopLoginCubit.get(context).changeSuffix();

                                }

                            ) ,
                            SizedBox(height: 40),
                            ConditionalBuilder(
                              condition: State is! ShopLoginLoadingState ,
                              builder: (BuildContext context) =>
                                buildButton(
                                    press: (){
                                      if(formKey.currentState!.validate()){
                                        print(emailController.text);
                                        print(passwordController.text);
                                        ShopLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text: 'login'),
                              fallback:(context)=> Center(
                                child:CircularProgressIndicator() ),


                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Do not have an account?',
                                  style: TextStyle(
                                      fontSize: 18
                                  ),),
                                buildTextInkWell(
                                    text: 'Register',
                                    tap: (){
                                      Navigator.
                                      of(context).push(
                                          MaterialPageRoute(builder: (context) =>RegisterScreen())
                                      );
                                    },
                                    fontSize: 18,
                                    isBoold:false

                                )
                              ],
                            )

                          ]
                      ),
                    ),
                  ),
                ),
              )
          );
        },

      )

    );
  }


}
//red #971d12
//yellow #ffe508







