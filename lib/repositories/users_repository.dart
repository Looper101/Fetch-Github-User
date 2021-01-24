import '../model/user.dart';
import 'users_api_client.dart';

class UserRepository {
  UserApiClient _userApiClient = UserApiClient();

  Future<List<User>> fetchUsers() async => await _userApiClient.fetchUsers();
}
