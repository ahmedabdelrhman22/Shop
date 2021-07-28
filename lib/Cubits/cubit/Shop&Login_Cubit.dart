import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/cubit/End_Point.dart';
import 'package:shop_app/Models/Categories_Model.dart';
import 'package:shop_app/Models/Change_Favorites_Model.dart';
import 'package:shop_app/Models/Dio.dart';
import 'package:shop_app/Models/Favorites_Model.dart';
import 'package:shop_app/Models/Home_Model.dart';
import 'package:shop_app/Models/Login_Model.dart';
import 'package:shop_app/Models/Search_Model.dart';
import 'package:shop_app/Modules/Categories_Screen.dart';
import 'package:shop_app/Modules/Favourites_Screen.dart';
import 'package:shop_app/Modules/Products_Screen.dart';
import 'package:shop_app/Modules/Search_Screen.dart';
import 'package:shop_app/Modules/Seetings_Screen.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

import 'Shop&Login_States.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit () : super(
      ShopLoginInitialState(
      )
      );
  LoginModel loginmodel;

  static ShopLoginCubit get (context) =>
      BlocProvider.of(
          context
          );
  int currentIndex = 0;
  List<Widget>bottomScreens = [
    ProductsScreen(
    ),
    CategoriesScreen(
    ),
    FavouritesScreen(
    ),
    SettingsScreen(
    ),


  ];

  void changeBottom (int index) {
    currentIndex = index;
    emit(
        ShopChangeButtonNavState(
        )
        );
  }







  HomeModel homemodel;
  Map<int,bool> favorites={};

  void getHomeData () {
    emit(
        ShopLoadingHomeDataState(
        )
        );
    DioHelper.getData(
       token: token,
        url: Home,
        ).then(
            (value) {
          homemodel = HomeModel.fromJson(
              value.data
              );
          print(
              homemodel.data.banners[0].image
              );
          homemodel.data.products.forEach((element) {
            favorites.addAll(
                {
                  element.id: element.in_favorites
                });
          });
          print(favorites.toString());
          emit(
              ShopSuccessHomeDataState(
              )
              );
        }
            ).catchError(
            (error) {
              print(
                  error.toString()
                  );

          emit(
              ShopErrorHomeDataState(
                  error.toString()
                  )

              );

        }
            );
  }

  ChangeFavoriteModel changeFavModel;
  void changeFavorites(int productId)
  {
    favorites[productId]=!favorites[productId];
    emit(ShopChangeFavoriteState());


    DioHelper.postData(url:FAVORITES ,data:{
      'product_id':productId,
    },token: token ).then((value) {
      changeFavModel=ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      if(!changeFavModel.status)

        {
          favorites[productId]=!favorites[productId];

        }
        else{getFavoritesData();}
      emit(ShopSuccessChangeFavoriteState(changeFavModel));

    } ).catchError((onError){
      favorites[productId]=!favorites[productId];

      emit(ShopErrorChangeFavoriteState(onError.toString()));
      print(onError.toString());

    });




  }






  CategoriesModel categoriesmodel;

  void getCategoriesData () {

    DioHelper.getData(
      token: token,
      url: CATEGORIES,
      ).then(
            (value) {
              categoriesmodel = CategoriesModel.fromJson(
              value.data
              );
          print(
              homemodel.data.banners[0].image
              );
          emit(
              ShopSuccessCategoriesState(
              )
              );
        }
            ).catchError(
            (error) {
          print(
              error.toString()
              );

          emit(
              ShopErrorCategoriesState(
                  error.toString()
                  )

              );

        }
            );
  }




  FavoritesModel favoritesModel;

  void getFavoritesData () {
emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      token: token,
      url: FAVORITES,
      ).then(
            (value) {
              favoritesModel = FavoritesModel.fromJson(
              value.data
              );
          print(
              value.data              );
          emit(
              ShopSuccessGetFavoritesState()
              );
        }
            ).catchError(
            (error) {
          print(
              error.toString()
              );

          emit(
              ShopErrorGetFavoritesState(
                  error.toString()


              ));

        }
            );
  }



  LoginModel user;

  void getUsers()
{   emit(ShopLoadingUserDataState());
    DioHelper.getData(
      token: token,
      url: PROFILE
      ).then(
            (value) {
              user = LoginModel.fromjson(
              value.data
              );
          print(
              user              );
          emit(
              ShopSuccessUserDataState(user));

        }
            ).catchError(
            (error) {
          print(
              error.toString()
              );

          emit(
              ShopErrorUserDataState(
                  error.toString()


                  ));

        }
            );
  }






  void updateUsersData(
  {
    @required String name,
    @required String email,
    @required String phone,

  }
      )
  {   emit(ShopLoadingUpdateUserState());
  DioHelper.updateData(
      token: token,
      url: UPDATE_PROFILE,
    data: {
        'name':name,
      'email':email,
      'phone':phone,


    },
      ).then(
          (value) {
        user = LoginModel.fromjson(
            value.data
            );
        print(
            user              );
        emit(
            ShopSuccessUpdateUserState(user));

      }
          ).catchError(
          (error) {
        print(
            error.toString()
            );

        emit(
            ShopErrorUpdateUserState(
                error.toString()


                ));

      }
          );
  }


  void userLogin(
  {
  @required String email,
  @required String password
}
      )
{
  emit(ShopLoginLoadingState());
    DioHelper.postData(url:Login ,data:{
      'email':email,
      'password':password,
    } ).then((value) {
      print(value.data);
      loginmodel= LoginModel.fromjson(value.data);
      print(loginmodel.status);
      print(loginmodel.message);

      print(loginmodel.data.token);
      emit(ShopLoginSuccessState(loginmodel));

    } ).catchError((onError){
      emit(ShopLoginErrorState(onError.toString()));
      print(onError.toString());

    });

  }
  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword ?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilityState());
  }

     SearchModel model;
  void search(String text)
  {
    emit(ShopLoadingSarchState());

    DioHelper.postData
      (url: PRODUCT_SEARCH
           , data:
       { 'text':text,},
      token: token,
                       ).then((value) {
      model=SearchModel.fromJson(value.data);
      print(model);
                         emit(ShopSuccessSearchState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorSearchState(error.toString()));
    });


  }





}