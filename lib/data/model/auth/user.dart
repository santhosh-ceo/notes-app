import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String password;

  User({required this.email, required this.name, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'], name: json['name'], password: json['password']);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [email, name, password];
}
