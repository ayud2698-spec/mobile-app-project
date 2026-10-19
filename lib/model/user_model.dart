// lib/model/user_model.dart

class UserResponse {
  final int page;
  final int totalPages;
  final List<User> data;

  UserResponse({
    required this.page,
    required this.totalPages,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      page: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      data: (json['data'] as List).map((i) => User.fromJson(i)).toList(),
    );
  }
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}
