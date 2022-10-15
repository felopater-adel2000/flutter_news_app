
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/science_screen.dart';
import 'package:news/sports_screen.dart';

import 'business_screen.dart';
import 'cash_helper.dart';
import 'dio_helper.dart';
import 'main.dart';

abstract class AppStates {}

class AppInitState extends AppStates{}
class AppChangeState extends AppStates{}
class AppSearchState extends AppStates
{
  late String _msg;
  AppSearchState(String inputmsg)
  {
    _msg = inputmsg;
  }

  String get Msg
  {
    return _msg;
  }
}

class AppCubit extends Cubit<AppStates>
{
  bool isLightMode = true;
  int bottomNavCurrentIndex = 0;
  Widget body = BusinessScreen();
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  List<dynamic> searchList = [];
  TextEditingController textController = TextEditingController();

  AppCubit({bool? isMode}) : super(AppInitState())
  {
    getBusinessData();
    getScienceData();
    getSportsData();

  }
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  void buildBusinessScreen()
  {
    body = BusinessScreen();
    bottomNavCurrentIndex = 0;
    emit(AppChangeState());
  }
  void buildScienceScreen()
  {
    bottomNavCurrentIndex = 2;
    body = ScienceScreen();
    emit(AppChangeState());
  }
  void buildSportsScreen()
  {
    bottomNavCurrentIndex = 1;
    body = SportsScreen();
    emit(AppChangeState());
  }

  void getBusinessData()
  {
    printDebug("Starting get Data");
    DioHelper dio = DioHelper();
    dio.getBusinessData().then((value)
    {
      business = value.data["articles"];
      emit(AppChangeState());
    }).catchError((error)
    {
      printDebug(error.toString());
    });
  }
  void getSportsData()
  {
    printDebug("Starting get Data");
    DioHelper dio = DioHelper();
    dio.getSportsData().then((value)
    {
      sports = value.data["articles"];
      emit(AppChangeState());
    }).catchError((error)
    {
      printDebug(error.toString());
    });
  }
  void getScienceData()
  {
    printDebug("Starting get Data");
    DioHelper dio = DioHelper();
    dio.getScienceData().then((value)
    {
      science = value.data["articles"];
      emit(AppChangeState());
    }).catchError((error)
    {
      printDebug(error.toString());
    });
  }
  void changeMode({bool? myIsLightMode})
  {
    printDebug("in AppCubit value of myIsLightMode is $myIsLightMode");
    if(myIsLightMode != null)
      {
        isLightMode = myIsLightMode;
        emit(AppChangeState());
      }
    else
      {
        isLightMode = !isLightMode;
        printDebug("value of isLightMode if $isLightMode");
        CacheHelper.putData("isLightMode", isLightMode).then((value)
        {
          printDebug("value from Share Prefrence ${CacheHelper.getData("isLightMode")}");
          emit(AppChangeState());
        });
      }


  }

  void getDataSearch(String search)
  {
    textController.text = search;
    textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
    searchList = [];
    DioHelper dio = DioHelper();
    dio.getSearchData({
      "q":search,
      "apiKey":"65f7f556ec76449fa7dc7c0069f040ca"
    }).then((value)
    {
      searchList = value.data["articles"];
      emit(AppChangeState());
    }).catchError((error)
    {
      printDebug("$error");
    });
  }

  void simpleTest()
  {}

}