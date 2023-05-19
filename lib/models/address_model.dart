class Contact {
  int? id;
  String? name;
  String? address;

  Contact({
    this.id,
    this.name,
    this.address,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,

    };
  }

  factory Contact.fromMap(Map<String, dynamic> json) {
    return new Contact(
      id: json['id'],
      name: json['name'],
     address: json['address'],

    );
  }
}
