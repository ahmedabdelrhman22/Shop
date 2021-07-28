import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Register_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Register_States.dart';
import 'package:shop_app/Layouts/Shop_Layout.dart';
import 'package:shop_app/Models/Cash_Helper.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

class RegisterScreen extends StatelessWidget {
  var FormKey=GlobalKey<FormState>();
  var NameController=TextEditingController();

  var EmailController=TextEditingController();
  var PasswordController=TextEditingController();
  var PhoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),

      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
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
          return Scaffold(
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
                        Text('REGISTER',style:Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
                             ),
                        Text
                          ('Register now to browse our hot offers',
                             style:Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
                           ),
                        SizedBox(height: 30.0,),
                        defaultFormField(
                          Controller: NameController,
                          type: TextInputType.name ,
                          ispassword: false,
                          validate: (String value){
                            if(value.isEmpty)
                            {
                              return 'Please enter your Name ';
                            }

                          },
                          label:'User Name' ,
                          prefix: Icons.person,


                          ),
                        SizedBox(height: 15.0,),

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
                          Controller: PhoneController,
                          type: TextInputType.phone ,
                          ispassword: false,
                          validate: (String value){
                            if(value.isEmpty)
                            {
                              return 'Please enter your phone number';
                            }

                          },
                          label:'Phone' ,
                          prefix: Icons.phone,


                          ),


                        SizedBox(height: 15.0,),
                        defaultFormField(
                          Controller: PasswordController,
                          type: TextInputType.visiblePassword ,

                          suffix:ShopRegisterCubit.get(context).suffix ,

                          ispassword: ShopRegisterCubit.get(context).isPassword,

                          suffixPressed:(){
                            ShopRegisterCubit.get(context).changePasswordVisibility();

                          },
                          validate: (String value){
                            if(value.isEmpty)
                            {
                              return 'Password is too short';
                            }

                          },
                          onSubmit: (value){

                          },

                          label:'Password' ,
                          prefix: Icons.lock_outline,


                          ),

                        SizedBox( height: 30.0,),

                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder:(context)=>defaultButton(
                              text: 'Register',
                              pressed: (){
                                if(FormKey.currentState.validate())
                                {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: NameController.text,
                                      email: EmailController.text,
                                      phone: PhoneController.text,

                                      password: PasswordController.text);

                                }

                              }
                              ),
                          fallback:(context)=> Center(
                            child: CircularProgressIndicator(

                            ),
                            ),
                          ),


                      ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        },

      ),
    );
  }
}
