class Address {
  Address({
    this.street,
    this.zipcode,
    this.addressName,
    this.isDefault,
    this.city,
  });

  final String street;
  final int zipcode;
  final String addressName;
  final String city;
  final bool isDefault;

  static List<Address> get addresses {
    return [
      Address(
        street: '84, Lorem Ipsum Layout',
        zipcode: 560079,
        addressName: 'Home',
        isDefault: true,
        city: 'Bangalore',
      ),
      Address(
        street: '127/54, Lorem Ipsum Layout',
        zipcode: 560009,
        addressName: 'Office',
        isDefault: false,
        city: 'Bangalore',
      ),
    ];
  }
}
