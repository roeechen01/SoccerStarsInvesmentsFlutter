import 'package:uuid/uuid.dart';

class User {
  String id;

  User({this.id}) {
    if (this.id == null) this.id = Uuid().v4();
  }
}
