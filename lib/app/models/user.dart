class User {
  final int id;
  final String username;
  final String fullname;
  final String address;
  final String phone;
  final String email;
  final bool role;
  final String? avatar;

  User({
    required this.id,
    required this.username,
    required this.fullname,
    required this.address,
    required this.phone,
    required this.email,
    required this.role,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      fullname: json['fullname'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      role: json['role'] as bool,
      avatar: json['avatar'],
    );
  }
}