import 'address.dart';

class Customer {
  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.addresses,
      this.avatar,
      this.email,
      this.phone});
  final int id;
  final String firstName;
  final String lastName;
  final List<Address> addresses;
  final String avatar;
  final String email;
  final String phone;

  String get name {
    return '$firstName $lastName';
  }
}
