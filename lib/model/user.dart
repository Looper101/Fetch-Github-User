import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final int id;
  final String imageUrl;
  User({this.name, this.id, this.imageUrl});
}
