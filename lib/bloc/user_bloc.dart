import 'package:bloc/bloc.dart';

import '../repositories/users_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // UserBloc() : super(UserInitial());

  final _userRepository = UserRepository();
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchGitUsers) {
      yield UserLoadInProgress();

      try {
        var result = await _userRepository.fetchUsers();
        print(result);
        yield UserLoadSuccess(users: result);
      } catch (e) {
        yield UserError(errorMessage: e.toString());
      }
    }
  }

  @override
  UserState get initialState => UserInitial();
}
