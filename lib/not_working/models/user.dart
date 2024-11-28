import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0; // Auto-increment ID
  String username;
  String password;

  User({required this.username, required this.password});
}
