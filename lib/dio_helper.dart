
import 'package:dio/dio.dart';

class DioHelper
{
  late Dio dio;

  DioHelper()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
        receiveDataWhenStatusError: true,
      )
    );

  }

  Future<Response> getBusinessData() async
  {
    return await dio.get(

      "v2/top-headlines",
      queryParameters:{
        "country":"eg",
        "category":"business",
        "apiKey":"65f7f556ec76449fa7dc7c0069f040ca"
      }
    );
  }
  Future<Response> getSportsData() async
  {
    return await dio.get(

        "v2/top-headlines",
        queryParameters:{
          "country":"eg",
          "category":"sports",
          "apiKey":"65f7f556ec76449fa7dc7c0069f040ca"
        }
    );
  }
  Future<Response> getScienceData() async
  {
    return await dio.get(

        "v2/top-headlines",
        queryParameters:{
          "country":"eg",
          "category":"science",
          "apiKey":"65f7f556ec76449fa7dc7c0069f040ca"
        }
    );
  }

  Future<Response> getSearchData(Map<String, dynamic> query) async
  {
    return await dio.get(
      "v2/everything",
      queryParameters: query
    );
  }

}