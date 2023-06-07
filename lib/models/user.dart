import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  String username;
  String name;
  String lastname;
  int age;
  int exercisesCompleted;
  int viewedFoods;
  int blogsReaded;

  User({
    required this.username,
    this.name = "usuario",
    this.lastname = "",
    this.age = 0,
    this.exercisesCompleted = 0,
    this.viewedFoods = 0,
    this.blogsReaded = 0,
  });

  User.load()
      : username = '',
        name = '',
        lastname = '',
        age = 0,
        exercisesCompleted = 0,
        viewedFoods = 0,
        blogsReaded = 0 {
    loadUser().then((value) {
      username = value.username;
      name = value.name;
      lastname = value.lastname;
      age = value.age;
      exercisesCompleted = value.exercisesCompleted;
      viewedFoods = value.viewedFoods;
      blogsReaded = value.blogsReaded;
    });
  }

  Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    User user = User(username: '');
    String? userString = prefs.getString('user');
    if (userString != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      user = User.fromJson(userMap);
      return user;
    }

    return user;
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'name': name,
        'lastname': lastname,
        'age': age,
        'exercisesCompleted': exercisesCompleted,
        'viewedFoods': viewedFoods,
        'blogsReaded': blogsReaded,
      };

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'],
        lastname = json['lastname'],
        age = json['age'],
        exercisesCompleted = json['exercisesCompleted'],
        viewedFoods = json['viewedFoods'],
        blogsReaded = json['blogsReaded'];
}
