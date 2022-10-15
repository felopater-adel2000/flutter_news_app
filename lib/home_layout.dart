
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/search_screen.dart';

import 'cubit.dart';
import 'main.dart';

class HomeLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  },
                  icon: Icon(Icons.search)
              ),
              IconButton(
                onPressed: ()
                {
                  printDebug("pressed Change Mode");
                  cubit.changeMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              )
            ],
          ),
          body: cubit.body,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomNavCurrentIndex,
            onTap: (index)
            {
              if(index == 0) cubit.buildBusinessScreen();
              else if(index == 1) cubit.buildSportsScreen();
              else if(index == 2) cubit.buildScienceScreen();

            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: "Business"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports),
                  label: "Sports"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: "Science"
              ),
            ],
          ),
        );
      },
    );
  }
}