import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Components/Components.dart';


class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state){},
          builder:(context,state){
          return Scaffold(
              appBar:AppBar(

              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        Controller: searchController,
                        type:TextInputType.text ,
                        validate: (value)
                          {
                            if(value.isEmpty) {
                              return 'Enter text to search';
                            }
                            else
                              return null;

                          },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit: (String text)
                          {

                            ShopLoginCubit.get(context).search(text);

                          }


                      ),
                      SizedBox(height: 10.0,),
                      if(state is ShopLoadingSarchState)
                        LinearProgressIndicator(),
            SizedBox(height: 10.0,),



            if(state is  ShopSuccessSearchState)
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context,index)=>buildListProduct(ShopLoginCubit.get(context).model.data.data[index],context,isOldPrice: false),
                  separatorBuilder: (context,index)=> Container(height: 0.5,width: double.infinity,color: Colors.grey,),
                  itemCount: ShopLoginCubit.get(context).model.data.data.length,
                  ),
            ),


                    ],
                  ),
                ),
              ),
              );
          },



    );
  }
}