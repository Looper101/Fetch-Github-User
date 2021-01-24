import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  UserEvent();

  @override
  List<Object> get props => [];
}

class FetchGitUsers extends UserEvent {}
