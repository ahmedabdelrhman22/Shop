import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Models/Cash_Helper.dart';
import 'package:shop_app/Modules/Login_Screen.dart';
import 'package:shop_app/Modules/Search_Screen.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:
            Text('Salla'
                 ),
            actions: [
              IconButton(
                  onPressed: (){

                    Navigate(context,SearchScreen());
                  },
                  icon: Icon(Icons.search))
            ],
            ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
           onTap: (index){
             cubit.changeBottom(index);

           },
            currentIndex: cubit.currentIndex,
            items: [

              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Category'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourite'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting'),

            ],
          ),
          );
      },

    );
  }
}
