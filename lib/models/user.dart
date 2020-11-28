//for mapping Fbuser to our custum user not necessary but makes things simple rather than accessing user from firebase directly

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}
