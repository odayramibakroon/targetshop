
 class UserViewModel {
  final String firstname;
  final String lastname;
  final String email;
  final int age;
  final String image;

  UserViewModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.image,
    required this.age,
  });

  factory UserViewModel.fromMap(Map<String, dynamic> map) {
    return UserViewModel(
   firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
      age: map['age'] ?? 0,
    );
  }
}
 
