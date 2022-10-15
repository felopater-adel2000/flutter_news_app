
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'cash_helper.dart';
import 'cubit.dart';
import 'home_layout.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? isLightMode = CacheHelper.getData("isLightMode");
  printDebug("in Main the value of CacheHelper is $isLightMode");
  runApp(MyApp(isLightMode));

}

void printDebug(String msg)
{
  print("---------------------debug---------------------- $msg");
}

class MyApp extends StatelessWidget
{
  final bool? isLightMode;
  MyApp(this.isLightMode);

  @override
  Widget build(BuildContext context)
  {
    printDebug("start build MaterialApp");
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AppCubit()..changeMode(myIsLightMode: isLightMode)),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  titleSpacing: 20,
                    elevation: 0.0,
                    color: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    actionsIconTheme: IconThemeData(
                      color: Colors.black,
                      size: 20,
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    unselectedItemColor: Colors.black,
                    selectedItemColor: Colors.deepOrange,
                    showUnselectedLabels: true,
                    selectedLabelStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: Colors.deepOrange,
                      size: 30,
                    ),
                    unselectedIconTheme: IconThemeData(
                      color: Colors.black,
                      size: 20,
                    )
                )
            ),
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white
                )
              ),
                scaffoldBackgroundColor: HexColor("3D3C3A"),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    elevation: 0.0,
                    color: HexColor("3D3C3A"),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor("3D3C3A"),
                        statusBarIconBrightness: Brightness.light
                    ),
                    titleTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    actionsIconTheme: const IconThemeData(
                      color: Colors.white,
                      size: 20,
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor("3D3C3A"),
                    unselectedLabelStyle: const TextStyle(
                        color: Colors.white
                    ),
                    unselectedItemColor: Colors.white,
                    selectedItemColor: Colors.deepOrange,
                    showUnselectedLabels: true,
                    selectedLabelStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    selectedIconTheme: const IconThemeData(
                      color: Colors.deepOrange,
                      size: 30,
                    ),
                    unselectedIconTheme: const IconThemeData(
                      color: Colors.white,
                      size: 20,
                    )
                )
            ),
            themeMode:  AppCubit.get(context).isLightMode ? ThemeMode.light : ThemeMode.dark,
            home: HomeLayout(),
          );
        },
      ),
    );
  }


}