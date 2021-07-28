import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Models/Cash_Helper.dart';
import 'package:shop_app/Models/Search_Model.dart';
import 'package:shop_app/Modules/Login_Screen.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

void Navigate(context,Widget)=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Widget));

void NavigateAndFinish(context,Widget)=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Widget),(Route<dynamic> route) =>false,);

Widget defaultFormField( {
  @required TextEditingController Controller,
  @required TextInputType type,
  @required Function validate,
   Function suffixPressed,

  @required String label,
  @required IconData prefix,
   IconData suffix,
   bool ispassword=false,

  Function onSubmit,
  Function onChange,
  Function onTap,

}) => TextFormField(


  controller: Controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  obscureText: ispassword,
  decoration: InputDecoration(
    suffixIcon:IconButton
      (icon: Icon(suffix),
         onPressed: suffixPressed,
         ),
    labelText: label,
    prefixIcon: Icon(prefix,),
    border: OutlineInputBorder(),
    ),

  );
Widget defaultButton(
{
  double width=double.infinity,
  Color background=Colors.blue,
  double radius=3.0,
  @required Function pressed,
  @required String text,
}
    )=> Container(
  width: width,
  color: background,
  child: MaterialButton(

    onPressed:pressed ,
          child: Text(text.toUpperCase(),style: TextStyle(color: Colors.white),) ,



),
    );
Widget defaultTextButton
(@required Function function,@required String text )
=>TextButton(onPressed: function, child: Text(text.toUpperCase()));


void ShowToast({@required String text,@required ToastStates state})=> Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:ToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0

);
enum ToastStates{
  SUCCESS,ERROR,WARNING
  }
Color ToastColor(ToastStates state)
{
  Color color;

  switch(state)
{
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
case ToastStates.WARNING:

  return Colors.amber;


  }
  return color;

}



///////////////shop/////////////////
void SignOut(context) {
  CashHelper.removeDate(
      key: 'token'
      ).then(
          (value) {
        if (value) {
          NavigateAndFinish(
              context, LoginScreen(
          )
              );
        }
      }
          );
}


  Widget buildListProduct( model,context,{bool isOldPrice= true})=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
            children: [
            Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
        Image(
        image: NetworkImage(model.image),
        width:120 ,
        height: 120.0,

        ),
      if(model.discount !=0 && isOldPrice)

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

  SizedBox(width: 20.0,),
  Expanded(
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
  Spacer(),
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
if(model.discount !=0 && isOldPrice)

Text(
'${model.oldPrice}',
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
),
);






