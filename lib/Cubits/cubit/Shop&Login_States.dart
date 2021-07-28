import 'package:shop_app/Models/Change_Favorites_Model.dart';
import 'package:shop_app/Models/Login_Model.dart';

abstract class ShopLoginStates{


}
class ShopLoginInitialState extends ShopLoginStates{

}
class ShopLoginLoadingState extends ShopLoginStates{

}
class ShopLoginSuccessState extends ShopLoginStates
{
 final LoginModel loginmodel;

  ShopLoginSuccessState(this.loginmodel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;

  ShopLoginErrorState(this.error);

}

class ShopChangePasswordVisibilityState extends ShopLoginStates{

}





////////////////////////// Shop/////////////////////////
class ShopChangeButtonNavState extends ShopLoginStates{

}
class ShopLoadingHomeDataState extends ShopLoginStates{

}
class ShopSuccessHomeDataState extends ShopLoginStates{

}
class ShopErrorHomeDataState extends ShopLoginStates{
  final String onerror;

  ShopErrorHomeDataState(this.onerror);

}

class ShopSuccessCategoriesState extends ShopLoginStates{

}
class ShopErrorCategoriesState extends ShopLoginStates{
  final String onerror;

  ShopErrorCategoriesState(this.onerror);

}


class ShopChangeFavoriteState extends ShopLoginStates{

}
class ShopSuccessChangeFavoriteState extends ShopLoginStates{
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavoriteState(this.model);

}
class ShopErrorChangeFavoriteState extends ShopLoginStates{
  final String onerror;

  ShopErrorChangeFavoriteState(this.onerror);

}

class ShopSuccessGetFavoritesState extends ShopLoginStates{

}
class ShopErrorGetFavoritesState extends ShopLoginStates{
  final String onerror;

  ShopErrorGetFavoritesState(this.onerror);

}


class ShopLoadingGetFavoritesState extends ShopLoginStates{

}


class ShopSuccessUserDataState extends ShopLoginStates{
  final LoginModel loginmodel;

  ShopSuccessUserDataState(this.loginmodel);

}
class ShopErrorUserDataState extends ShopLoginStates{
  final String onerror;

  ShopErrorUserDataState(this.onerror);

}


class ShopLoadingUserDataState extends ShopLoginStates{

}




class ShopSuccessUpdateUserState extends ShopLoginStates{
  final LoginModel loginmodel;

  ShopSuccessUpdateUserState(this.loginmodel);

}
class ShopErrorUpdateUserState extends ShopLoginStates{
  final String onerror;

  ShopErrorUpdateUserState(this.onerror);

}


class ShopLoadingUpdateUserState extends ShopLoginStates{

}






class ShopSuccessSearchState extends ShopLoginStates{


}
class ShopErrorSearchState extends ShopLoginStates{
  final String onerror;

  ShopErrorSearchState(this.onerror);

}


class ShopLoadingSarchState extends ShopLoginStates{

}