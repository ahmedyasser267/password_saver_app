class Web {
  int? id;
  String? name;
  String? email;
  String? password;


  Web({
    this.id,
    this.name,
    this.email,
    this.password

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password':password

    };
  }

  factory Web.fromMap(Map<String, dynamic> json) {
    return new Web(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password']

    );
  }
}
