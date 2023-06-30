class User {
  String username;
  int postReadIt;
  int exercisesDoIt;
  int viewedFood;

  User({
    this.username = "usuario",
    this.postReadIt = 0,
    this.exercisesDoIt = 0,
    this.viewedFood = 0,
  });

  Map<dynamic, dynamic> toJson() => {
        'username': username,
        'postReadIt': postReadIt,
        'exercisesDoIt': exercisesDoIt,
        'viewedFood': viewedFood,
      };

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        username: json['username'],
        postReadIt: json['postReadIt'],
        exercisesDoIt: json['exercisesDoIt'],
        viewedFood: json['viewedFood'],
      );
}
