class UserModel{

  final String name;
  final int id;
  final String email;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
        name: jsonData['name'],
        id: jsonData['id'],
        email: jsonData['email'],
    );
  }
}

//all_points: 0, active_points: 950, level_points: 1000, redeemed_points: 0,
//points: 950, total_points: 950, pending_points: 0,