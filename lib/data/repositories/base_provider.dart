import 'package:get/get.dart';
import 'package:movie_app_sheba_xyz/main.dart';
import 'package:http/http.dart' as http;

class BaseProviders extends GetConnect{

  Map<String, String> headerData = {
    'accept': 'application/json',
    'Authorization': 'Bearer ${preferences.getString('access_token')}',
  };

  Future<http.Response?> getResponseWithAccessToken({required String url}) async {
    try {
      print('${preferences.getString('access_token')}');

      print(headerData);

      var response = await http.get(Uri.parse(url), headers: headerData);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 401) {

      } else if (response.statusCode == 200 || response.statusCode == 201) {

        return response;

      } else {

        return null;

      }
    } catch (error) {

      print('not fount notebook list $error');

    }

    return null;

  }

}