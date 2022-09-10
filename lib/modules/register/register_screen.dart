import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var emailRegistController=TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child:Form(
            child: Column(
              children: [
                buildTextField(
                    controller: emailRegistController,
                    type:TextInputType.text,
                    ic: Icons.email_rounded,
                    label: 'email')
              ],
            )


          )
        ),
      ),
    );
  }
}
