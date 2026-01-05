class UserViewModel {
  final String firstname;
  final String lastname;
  final String image;
  final bool isVerified;  

  UserViewModel({
    required this.firstname,
    required this.lastname,
    required this.image,
    required this.isVerified,
 
  });

   UserViewModel copyWith({
    String? firstname,
    String? lastname,
    String? image,
    bool? isVerified,
  }) {
    return UserViewModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      image: image ?? this.image,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory UserViewModel.fromMap(Map<String, dynamic> map) {
    return UserViewModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      image: map['image'] ?? '',
      isVerified: map['verifiedaccount'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'image': image,
      'verifiedaccount': isVerified,
    };
  }
}
