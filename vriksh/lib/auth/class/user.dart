class user {
  var email;
  var fname;
  var lname;
  var token;

  user(this.email, this.fname, this.lname, this.token);
  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      json['email'],
      json['fname'],
      json['lname'],
      json['token'],
    );
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fname': fname,
      'lname': lname,
      'token': token,
    };
  }
}

class loginUser {
  var email;
  var password;

  loginUser(var a, var b) {
    email = a;
    password = b;
  }
}
