import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/state.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/state.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey=GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child:BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is ShopRegisterSuccessfulState){
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
                            Text('Register',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4!.copyWith(color: Colors.black)
                            ),
                            SizedBox(height: 10,),
                            buildTextField(
                              controller: nameController,
                              ic: Icons.title,
                              label: 'name',
                              type: TextInputType.text,
                            ),
                            SizedBox(height: 20,),
                            buildTextField(
                                controller: emailController,
                                ic: Icons.email_rounded,
                                label: 'email',
                                type: TextInputType.text,

                            ) ,
                            SizedBox(height: 20,),
                            buildTextField(
                                controller: phoneController,
                                ic: Icons.phone,
                                label: 'phone',
                                type: TextInputType.phone,

                            ),
                            SizedBox(height: 20,),
                            buildTextField(
                                controller: passwordController,
                                ic: Icons.password_outlined,
                                label: 'password',
                                type: TextInputType.text,
                                suffix: ShopRegisterCubit.get(context).changeVisiblity,
                                obsecure:ShopRegisterCubit.get(context).ispassword ,
                                suffixPressd: (){
                                  ShopRegisterCubit.get(context).changeSuffix();
                                }
                            ),
                            SizedBox(height: 40),
                            ConditionalBuilder(
                              condition: State is! ShopRegisterLoadingState ,
                              builder: (BuildContext context) =>
                                buildButton(
                                    press: (){
                                      if(formKey.currentState!.validate()){
                                        print(emailController.text);
                                        print(passwordController.text);
                                        ShopRegisterCubit.get(context).userRegister(
                                          name:nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    text: 'REGISTER'),
                              fallback:(context)=> Center(
                                child:CircularProgressIndicator() ),
                            ),
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







