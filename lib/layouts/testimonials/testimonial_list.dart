import 'package:flutter/material.dart';

import '../../model/testimonial.dart';
import '../common/horizontal_spacer.dart';
import 'testimonial_list_item.dart';

class TestimonialList extends StatelessWidget {
  const TestimonialList({
    @required this.testimonials,
    this.onReadMoreClick,
    Key key,
  }) : super(key: key);

  final List<UserTestimonial> testimonials;
  final ValueChanged<UserTestimonial> onReadMoreClick;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: testimonials.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            TestimonialListItem(
              userTestimonial: testimonials[index],
              onReadMoreClick: onReadMoreClick,
            ),
            const HorizontalSpacer(space: 16),
          ],
        );
      },
    );
  }
}
