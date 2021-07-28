import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Models/Favorites_Model.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,State){

      },
      builder:(context,State)=> ConditionalBuilder(
        condition: State is! ShopLoadingGetFavoritesState ,
        builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildListProduct(ShopLoginCubit.get(context).favoritesModel.data.data[index].product,context),
            separatorBuilder: (context,index)=> Container(height: 0.5,width: double.infinity,color: Colors.grey,),
            itemCount: ShopLoginCubit.get(context).favoritesModel.data.data.length
            ),
        fallback: (context)=>Center(child: CircularProgressIndicator()),

        ),
      );
  }

}