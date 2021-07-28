import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Models/Categories_Model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,State){

      },
      builder:(context,State)=> ListView.separated(
          itemBuilder: (context,index)=>buildCatItem(ShopLoginCubit.get(context).categoriesmodel.data.data[index]),
          separatorBuilder: (context,index)=> Container(height: 0.5,width: double.infinity,color: Colors.grey,),
          itemCount: ShopLoginCubit.get(context).categoriesmodel.data.data.length
          ),
    );
  }
  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image
          (image: NetworkImage(model.image),
             width: 80.0,
             height: 80.0,
             fit: BoxFit.cover,
           ),
        SizedBox(height: 20.0),
        Text(
          model.name,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ,),
        Spacer(),
        Icon(Icons.arrow_forward_ios),


      ],
      ),
    );
}