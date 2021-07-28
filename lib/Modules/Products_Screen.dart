import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Models/Categories_Model.dart';
import 'package:shop_app/Models/Change_Favorites_Model.dart';
import 'package:shop_app/Models/Home_Model.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(

      listener: (context,state){
        if(state is ShopSuccessChangeFavoriteState)
          {
            if(!state.model.status)
              {
                ShowToast(text:state.model.message,state: ToastStates.ERROR );
              }
          }

      },
        builder: (context,state){
        return ConditionalBuilder(
          condition:ShopLoginCubit.get(context).homemodel != null && ShopLoginCubit.get(context).categoriesmodel != null ,
          builder:  (context)=>
             ProductsBuilder( ShopLoginCubit.get(context).homemodel,ShopLoginCubit.get(context).categoriesmodel,context),

          fallback: (context)=>Center(child: CircularProgressIndicator()) ,
        );

        }
        );
  }
  Widget ProductsBuilder(HomeModel model ,CategoriesModel categoriesModel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners.map(
                  (e) =>
                  Image(
                    image: NetworkImage(
                        '${e.image}'
                        ),
                    width: double.infinity,

                    ),
                  ).toList(
            ),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(
                  seconds: 3
                  ),
              autoPlayAnimationDuration: Duration(
                  seconds: 1
                  ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,


              ),
            ),
          SizedBox(
            height: 10.0,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories',style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
                     ),
                SizedBox(
                  height: 10.0,
                  ),

                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                      itemCount: categoriesModel.data.data.length
                      ),
                ),
                SizedBox(
                  height: 20.0,
                  ),


                Text('New Products',style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                  ),
                     ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
            ),

          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(
                ),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.9,
                children: List.generate(
                    model.data.products.length, (index) =>
                    buildGridProduct(
                        model.data.products[index],context
                        )

                    )

                ),
            ),


        ],
        ),
      );
  }
  Widget buildGridProduct(product model,context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
    alignment: AlignmentDirectional.bottomStart,
           children: [
                Image(
                image: NetworkImage(model.image),
                width:double.infinity ,
                height: 200.0,
//                fit: BoxFit.cover,

                   ),
              if(model.discount !=0)

               Container(
                    color: Colors.red,
                     padding: EdgeInsets.symmetric(horizontal: 5.0),
                     child:
                    Text('Discount',style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                     ),
                     ),
                     ),
                    ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,

  children: [
              Text(
                model.name,maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle
                  (fontSize: 14.0,
                       height: 1.3
                   ),
                   ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: TextStyle
                      (fontSize: 12.0,
                         color: defaultColor,
                       ),
                    ),
                  SizedBox(width: 5.0,),
                  if(model.discount !=0)

                  Text(
                    '${model.old_price}',
                    style: TextStyle
                      (fontSize: 10.0,
                         color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                       ),
                    ),
                       Spacer(),
                   IconButton(
                    onPressed: (){

  ShopLoginCubit.get(context).changeFavorites(model.id);

                   },
                 icon:
                  CircleAvatar(
                   backgroundColor: ShopLoginCubit.get(context).favorites[model.id]?defaultColor : Colors.grey,
                       radius: 15.0,
                    child: Icon( Icons.favorite_border
                        ),
                  ),
                  iconSize: 14.0,
                  color: Colors.white,
                    )
                ],
              ),
            ],
          ),
        ),

      ],
      ),
  );

    Widget buildCategoryItem(DataModel model)=>Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image:NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,


          ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.8),
          child: Text
            (model.name,
               textAlign: TextAlign.center,
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(color: Colors.white),),
          )
      ],
      );


}
