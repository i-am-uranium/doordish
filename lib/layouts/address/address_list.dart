import 'package:flutter/material.dart';

import '../../model/address.dart';
import '../../utils/logger.dart';
import '../common/horizontal_spacer.dart';
import 'address_card.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    this.addresses = const [],
    this.onAddressChangeClick,
    this.onAddNewAddressClick,
    Key key,
  }) : super(key: key);
  final List<Address> addresses;
  final ValueChanged<Address> onAddressChangeClick;
  final Function onAddNewAddressClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            AddressCard(
              address: addresses[index],
              onAddressChangeClick: (address) {
                logger.i('Address city: ${address.city}');
              },
            ),
            const HorizontalSpacer(
              space: 16,
            ),
          ],
        );
      },
    );
  }
}
