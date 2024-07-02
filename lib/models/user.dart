class User {
  final String gender;
  final String title;
  final String firstName;
  final String lastName;
  final String email;
  final String picture;

  User({
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['gender'],
      title: json['name']['title'],
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      picture: json['picture']['large'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'picture': picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      gender: map['gender'],
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      picture: map['picture'],
    );
  }
}