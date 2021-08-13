enum Gender { male, female }

class RegisterRequest {
  String id;
  String email;
  String password;
  String userName;
  Gender gender;
  String phoneNumber;
  String city;
  String country;

  RegisterRequest({
    this.id,
    this.email,
    this.password,
    this.userName,
    this.phoneNumber,
    this.gender,
    this.city,
    this.country,
  });

  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'userName': this.userName,
      'phoneNumber': this.phoneNumber,
      'gender': this.gender == Gender.male ? 'male' : 'female',
      'country': this.country,
      'city': this.city,
    };
  }
}
