import 'package:equatable/equatable.dart';

import '../model/user.dart';

abstract class UserState extends Equatable {
  // const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProgress extends UserState {}

class UserLoadSuccess extends UserState {
  final List<User> users;

  UserLoadSuccess({this.users});
}

class UserError extends UserState {
  final String errorMessage;
  UserError({
    this.errorMessage,
  });
}
