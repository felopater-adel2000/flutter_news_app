
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news/share.dart';

import 'cubit.dart';

class SearchScreen extends StatelessWidget
{


  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        AppCubit cubit = AppCubit.get(context);
        //cubit.textController.selection = TextSelection.fromPosition(TextPosition(offset: cubit.textController.text.length));
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    onChange: (value)
                    {
                      cubit.getDataSearch(value);
                    },
                    controller: cubit.textController,
                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if(value != null && value.isEmpty)
                      {
                        return "search must not be empty";
                      }
                      return null;
                    },
                    label: "search",
                    prefix: Icons.search
                ),
              ),
              Expanded(
                child: Conditional.single(
                    context: context,
                    conditionBuilder: (context) => cubit.searchList.length > 0,
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
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget buildRow(BuildContext context, int index)
  {
    AppCubit cubit = AppCubit.get(context);
    String url = "https://c1.wallpaperflare.com/preview/811/367/789/technology-computer-creative-design.jpg";
    if(cubit.searchList[index]["urlToImage"] != null)
    {
      url = cubit.searchList[index]["urlToImage"];
    }
    return Padding(
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
                        "${cubit.searchList[index]["title"]}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                  ),
                  Text("${cubit.searchList[index]["publishedAt"]}",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}