import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Components/Components.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_Cubit.dart';
import 'package:shop_app/Cubits/cubit/Shop&Login_States.dart';
import 'package:shop_app/Models/Cash_Helper.dart';
import 'package:shop_app/Modules/Login_Screen.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String Image;
  final String title;
  final String body;

  BoardingModel(this.Image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardController=PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        'assets/onboarding-1.jpg', 'On Board 1 Title', 'On Board 1 Body'),
    BoardingModel(
        'assets/onboarding-1.jpg', 'On Board 2 Title', 'On Board 2 Body'),
    BoardingModel(
        'assets/onboarding-1.jpg', 'On Board 3 Title', 'On Board 3 Body'),
  ];
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener:(context,state){

      } ,
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: ()
                  {

                    submit();
                  }, child: Text('SKIP'))
            ],

            ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index){
                      if(index==boarding.length-1)
                      {
                        setState(() {
                          isLast=true;
                        });
                        print('last');
                      }
                      else{
                        setState(() {
                          isLast=false;
                        });
                        print('is not last');
                      }

                    },
                    physics:BouncingScrollPhysics(),
                    controller: BoardController,
                    itemBuilder: (context,index)=>BuildBoardingItem(boarding[index]),
                    itemCount: boarding.length,),
                  ),
                SizedBox(height: 40.0),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: BoardController,
                      effect:   ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10.0,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                        activeDotColor: defaultColor,
                        ),
                      count: boarding.length,
                      ),
                    Spacer(),
                    FloatingActionButton(
                        child:Icon(Icons.arrow_forward_ios),
                        onPressed: ()
                        {
                          if(isLast)
                          {
                            submit();
                          }
                          else {
                            BoardController.nextPage(
                                duration: Duration(
                                    milliseconds: 750
                                    ), curve: Curves.fastLinearToSlowEaseIn
                                );
                          }
                        }
                        ),

                  ],
                  )

              ],
              ),
            ),

          );
      },


    );

  }

  Widget BuildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.Image}'))),
      SizedBox(height: 30.0,),
      Text('${model.title}',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,

        ),
           ),
      SizedBox(height: 14.0,),
      Text('${model.body}',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,

        ),

           ),

      SizedBox(height: 30.0,),

    ],
    );
  void submit()
  {
    CashHelper.saveData
      ( key: 'onBoarding',value: true).then
      ((value)
       {
         if(value)
         {
           NavigateAndFinish(context,LoginScreen());

         }
       }
       );


  }
}
