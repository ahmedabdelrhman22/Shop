import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(

      listener: (context,state){},
      builder: (context,state){
        var model=ShopLoginCubit.get(context).user;
        nameController.text=model.data.name;
        emailController.text=model.data.email;
        phoneController.text=model.data.phone;

        return ConditionalBuilder(
          condition: ShopLoginCubit.get(context).user != null,
          builder:(context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)

                  LinearProgressIndicator(),
                  SizedBox(height: 20.0,),
                  defaultFormField(
                    Controller:nameController ,
                    type: TextInputType.name,
                    validate: (value){
                      if(value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                    ),
                  SizedBox(height: 20.0,),
                  defaultFormField(
                    Controller:emailController ,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                    ),
                  SizedBox(height: 20.0,),

                  defaultFormField(
                    Controller:phoneController ,
                    type: TextInputType.phone,
                    validate: (value){
                      if(value.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                    ),

                  SizedBox(height: 20.0,),
                  defaultButton(
                      pressed: (){
                        if(formKey.currentState.validate()) {
                          ShopLoginCubit.get(
                              context
                              ).updateUsersData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,

                            );
                        }
                      },
                      text: 'Update'
                      ),
                  SizedBox(height: 20.0,),
                 defaultButton(
                     pressed: (){
                       SignOut(context);
                     },
                     text: 'Logout'
                     ),

                ],
                ),
            ),
            ) ,
          fallback:(context)=> Center(child: CircularProgressIndicator()),

        );
      },

    );
  }
}