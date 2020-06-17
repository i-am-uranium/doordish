import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../model/address.dart';
import '../address/add_new_address.dart';
import '../address/address_page_view.dart';
import '../common/vertical_spacer.dart';

class EditOrderDeliveryDetail extends StatefulWidget {
  const EditOrderDeliveryDetail({Key key}) : super(key: key);

  @override
  _EditOrderDeliveryDetailState createState() =>
      _EditOrderDeliveryDetailState();
}

class _EditOrderDeliveryDetailState extends State<EditOrderDeliveryDetail> {
  final PageController _pageViewController = PageController();
  bool _firstPage = true;
  String _title = 'Step 1/2';

  @override
  void initState() {
    super.initState();
    _pageViewController.addListener(() {
      if (_pageViewController.page == 0) {
        setState(() {
          _firstPage = true;
        });
      } else {
        setState(() {
          _firstPage = false;
        });
      }
      setState(() {
        _title = 'Step ${_pageViewController.page.floor() + 1}/2';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        width: MediaQuery.of(context).size.width * .28,
        height: MediaQuery.of(context).size.height,
        color: AppColors.white,
        padding: const EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: 32,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_firstPage)
                  const SizedBox(
                    width: 40,
                  )
                else
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                    ),
                    onPressed: () {
                      _pageViewController.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 15,
                    letterSpacing: .18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const VerticalSpacer(
              space: 24,
            ),
            Expanded(
              child: PageView(
                controller: _pageViewController,
                children: [
                  AddressPageView(
                    addresses: Address.addresses,
                  ),
                  const AddNewAddress(),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .28 - 80,
              height: 40,
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  _pageViewController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  );
                },
                child: const Text('Next',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
