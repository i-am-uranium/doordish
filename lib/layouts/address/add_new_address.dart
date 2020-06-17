import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:js/js.dart';

import '../../api/location_provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../helper/location.dart';
import '../../model/address.dart';
import '../../model/location.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({
    this.addresses,
    Key key,
  }) : super(key: key);
  final List<Address> addresses;

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  LocationModel locationData;

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Assets.homeIllustration,
          width: 300,
          height: 184,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 32,
          ),
          child: Text(
            'Which Address Do You Want to Receive Your Order?',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: .18,
              height: 1.7,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _cityController,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter the complete address (floor, app no)',
                  prefixIcon: IconButton(
                    icon: const Icon(
                      FontAwesome.location_arrow,
                      size: 16,
                    ),
                    onPressed: () {
                      getCurrentPosition(
                        allowInterop(
                          (pos) {
                            LocationAPI().fetchData().then((value) {
                              setState(() {
                                locationData = value;
                                _cityController.text =
                                    '${value.city}, ${value.state}';
                              });
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const VerticalSpacer(),
              TextFormField(
                controller: _streetController,
                cursorColor: AppColors.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Enter the complete address (floor, app no)',
                ),
              ),
              const VerticalSpacer(),
              TextFormField(
                controller: _addressNameController,
                cursorColor: AppColors.primaryColor,
                decoration: const InputDecoration(
                  hintText: 'Enter the address name(work, home)',
                ),
              ),
              const VerticalSpacer(),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    activeColor: AppColors.white,
                    checkColor: AppColors.primaryColor,
                    onChanged: (value) {},
                  ),
                  const HorizontalSpacer(),
                  const Text('Make this my default address?'),
                ],
              ),
            ],
          ),
        ),
        const VerticalSpacer(
          space: 64,
        ),
      ],
    );
  }
}
