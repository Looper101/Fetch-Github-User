import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';

//Serialization, http request call to api took place here
class UserApiClient {
  Future<List<User>> fetchUsers() async {
    final String endPoint = 'https://api.github.com/users';

    http.Response response = await http.get(endPoint);
    final List<User> fetchedUser = [];
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);

      responseData.forEach(
        (dynamic element) {
          final User user = User(
              name: element['login'],
              id: element['id'],
              imageUrl: element['avatar_url']);
          fetchedUser.add(user);
          print(fetchedUser);
        },
      );
    }
    return fetchedUser;
  }
}
