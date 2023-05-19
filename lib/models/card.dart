class MyCard {
  int? id;
  String? name;
  String? cardNumber;
  String? pin;
  String? password;

  MyCard({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.pin,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cardNumber': cardNumber,
      'pin': pin,
      'password': password,
    };
  }

  MyCard.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cardNumber = json['cardNumber'];
    pin = json['pin'];
    password = json['password'];
  }
}
