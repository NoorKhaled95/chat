enum Gender { mail, female }

class RegisterRequest {
  String email;
  String password;
  String userName;
  Gender gender;
  String phoneNumber;
  String city;
  String country;

  RegisterRequest({
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
      'email': this.email,
      'userName': this.userName,
      'phoneNumber': this.phoneNumber,
      'gender': this.gender == Gender.mail ? 'male' : 'female',
      'country': this.country,
      'city': this.city,
    };
  }
}
