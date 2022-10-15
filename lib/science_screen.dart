
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news/web_view_screen.dart';

import 'cubit.dart';

class ScienceScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.science.length > 0,
              widgetBuilder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) => buildRow(context, index),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Container(
                    height: 1,
                  ),
                ),
              ),
              fallbackBuilder: (context) => Center(child: CircularProgressIndicator())
          );
        }
    );
  }

  Widget buildRow(BuildContext context, int index)
  {
    AppCubit cubit = AppCubit.get(context);
    String url = "https://c1.wallpaperflare.com/preview/811/367/789/technology-computer-creative-design.jpg";
    if(cubit.science[index]["urlToImage"] != null)
    {
      url = cubit.science[index]["urlToImage"];
    }
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(cubit.science[index]["url"])));
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children:  [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image:  DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover
                  )
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                          "${cubit.science[index]["title"]}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1
                        )
                    ),
                    Text("${cubit.science[index]["publishedAt"]}",
                        style: Theme.of(context).textTheme.bodyText1
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}