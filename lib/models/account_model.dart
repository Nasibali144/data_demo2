class Account {
  String email;
  String number;
  String address;

  Account({this.email, this.number, this.address});

  Account.fromJson(Map<dynamic, dynamic> json)
  : email = json['email'],
    number = json['number'],
    address = json['address'];

  Map<dynamic, dynamic> toJson() => {
    'email' : email,
    'number' : number,
    'address' : address,
  };
}