import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Layouts/Shop_Layout.dart';
import 'package:shop_app/Models/Cash_Helper.dart';
import 'package:shop_app/Models/Dio.dart';
import 'package:shop_app/Modules/Login_Screen.dart';
import 'package:shop_app/Modules/OnBoarding_Screen.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';


import 'Shared/Styles/Themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  await CashHelper.init();
  Widget widget;

  bool onboarding=CashHelper.getData(key: 'onBoarding');
   token=CashHelper.getData(key: 'token');
   print(token);
   if(onboarding != null)
    {
      if(token != null) widget=ShopLayout();
      else widget=LoginScreen();

    }
    else
      {
        widget=OnBoardingScreen();
      }

  print(onboarding);
  runApp(MyApp(
    StartWidget: widget,
  ));

}

class MyApp extends StatelessWidget {
  final Widget StartWidget;
  const MyApp({ this.StartWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopLoginCubit()..getHomeData()..getCategoriesData()..getCategoriesData ()..getUsers()),
//    BlocProvider(create: (BuildContext context)=> ShopLoginCubit(),)

    ],
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
        },
        builder: (context,state){
          return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: LightTheme,
                  home: StartWidget,


            );



        },
        ),

      );

  }
}

