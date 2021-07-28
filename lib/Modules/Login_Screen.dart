import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Layouts/Shop_Layout.dart';

import 'package:shop_app/Models/Cash_Helper.dart';
import 'package:shop_app/Modules/Register_Screen.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

class LoginScreen extends StatelessWidget {
  var FormKey=GlobalKey<FormState>();

  var EmailController=TextEditingController();
  var PasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
            {
              if(state.loginmodel.status)
                {
                  CashHelper.saveData(key: 'token', value: state.loginmodel.data.token)
                      .then((value) {
                        NavigateAndFinish(context,ShopLayout());
                      token=state.loginmodel.data.token;


                      });

                  ShowToast(text:state.loginmodel.message  ,state: ToastStates.SUCCESS );


                }
                else{

                ShowToast(text:state.loginmodel.message  ,state: ToastStates.WARNING );


              }
            }


        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style:Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
                             ),
                        Text
                          ('Login now to browse our hot offers',
                             style:Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
                           ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                          Controller: EmailController,
                          type: TextInputType.emailAddress ,
                          ispassword: false,
                          validate: (String value){
                            if(value.isEmpty)
                            {
                              return 'Please enter your email address';
                            }

                          },
                          label:'Email Address' ,
                          prefix: Icons.email_outlined,


                          ),
                        SizedBox( height: 15.0,),
                        defaultFormField(
                          Controller: PasswordController,
                          type: TextInputType.visiblePassword ,

                          suffix:ShopLoginCubit.get(context).suffix ,

                          ispassword: ShopLoginCubit.get(context).isPassword,

                          suffixPressed:(){
                            ShopLoginCubit.get(context).changePasswordVisibility();

                          },
                          validate: (String value){
                            if(value.isEmpty)
                            {
                              return 'Password is too short';
                            }

                          },
                          onSubmit: (value){

                            if(FormKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(email: EmailController.text, password: PasswordController.text);


                            }
                          },

                          label:'Password' ,
                          prefix: Icons.lock_outline,


                          ),
                        SizedBox( height: 30.0,),

                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                          builder:(context)=>defaultButton(
                              text: 'Login',
                              pressed: (){
                                if(FormKey.currentState.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(email: EmailController.text, password: PasswordController.text);


                                  }

                              }
                              ),
                          fallback:(context)=> Center(
                            child: CircularProgressIndicator(

                            ),
                          ),
                        ),
                        SizedBox( height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account '),
                            defaultTextButton((){
                              Navigate(context,RegisterScreen());
                            },  'Register'),
                          ],

                          ),


                      ],
                      ),
                  ),
                  ),
                ),
              ),
            );
        },

      );

  }
}
