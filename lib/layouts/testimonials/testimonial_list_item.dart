import 'package:flutter/material.dart';

import '../../model/testimonial.dart';
import 'testimonial_card.dart';

class TestimonialListItem extends StatelessWidget {
  const TestimonialListItem({
    @required this.userTestimonial,
    this.onReadMoreClick,
    Key key,
  }) : super(key: key);

  final UserTestimonial userTestimonial;
  final ValueChanged<UserTestimonial> onReadMoreClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 350,
      child: Stack(
        children: [
          Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              userTestimonial.imageUrl,
              fit: BoxFit.cover,
              width: 330,
              height: 234,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TestimonialCard(
              testimonial: userTestimonial,
              onReadMoreClick: onReadMoreClick,
            ),
          ),
        ],
      ),
    );
  }
}
