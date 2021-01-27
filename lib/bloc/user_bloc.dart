import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:github_user/model/exception.dart';

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
      yield* _mapFetchGitUserState();
    }
  }

  Stream<UserState> _mapFetchGitUserState() async* {
    try {
      var result = await _userRepository.fetchUsers();
      print(result);
      yield UserLoadSuccess(users: result);
    } on SocketException {
      yield UserError(errorMessage: NetworkException().errorExceptionMessage);
    }
  }

  @override
  UserState get initialState => UserInitial();
}
