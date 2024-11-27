import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;

  String? username;
  String? password;

  User(this.username, this.password);
}