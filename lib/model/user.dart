class User {
  final int id;
  final String username;
  final String name;

  User({
    required this.id,
    required this.username,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      id: user['userid'],
      username: user['username'],
      name: user['name'],
    );
  }
}
