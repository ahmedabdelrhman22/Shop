import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubits/cubit/End_Point.dart';
import 'package:shop_app/Cubits/cubit/Register_States.dart';
import 'package:shop_app/Models/Dio.dart';
import 'package:shop_app/Models/Login_Model.dart';
import 'package:shop_app/Shared/Styles/constant/constant.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit () : super(
      ShopRegisterInitialState(
      )
      );

  static ShopRegisterCubit get (context) =>
      BlocProvider.of(
          context
          );


  LoginModel loginmodel;

  void userRegister ({
    @required String name,

    @required String email,
    @required String password,
    @required String phone,

  }) {
    emit(
        ShopRegisterLoadingState(
        )
        );
    DioHelper.postData(
        url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,

    }
        ).then(
            (value) {
          print(
              value.data
              );
          loginmodel = LoginModel.fromjson(
              value.data
              );
          print(
              loginmodel.status
              );
          print(
              loginmodel.message
              );

          print(
              loginmodel.data.token
              );
          emit(
              ShopRegisterSuccessState(
                  loginmodel
                  )
              );
        }
            ).catchError(
            (onError) {
          emit(
              ShopRegisterErrorState(
                  onError.toString(
                  )
                  )
              );
          print(
              onError.toString(
              )
              );
        }
            );
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility () {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(
        ShopChangePasswordVisibilityState(
        )
        );
  }
}




