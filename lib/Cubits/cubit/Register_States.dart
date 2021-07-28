import 'package:shop_app/Models/Login_Model.dart';

abstract class ShopRegisterStates{


}
class ShopRegisterInitialState extends ShopRegisterStates{

}
class ShopRegisterLoadingState extends ShopRegisterStates{

}
class ShopRegisterSuccessState extends ShopRegisterStates
{
  final LoginModel loginmodel;

  ShopRegisterSuccessState(this.loginmodel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;

  ShopRegisterErrorState(this.error);

}

class ShopChangePasswordVisibilityState extends ShopRegisterStates{

}