import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../model/testimonial.dart';
import '../common/hand_cursor_inkwell.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({
    @required this.testimonial,
    this.onReadMoreClick,
    Key key,
  }) : super(key: key);
  final UserTestimonial testimonial;
  final ValueChanged<UserTestimonial> onReadMoreClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 244,
      height: 172,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'by ',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.2,
                    letterSpacing: .18,
                    color: AppColors.secondaryText,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: testimonial.user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.2,
                        letterSpacing: .18,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: ', ${testimonial.publishDate}',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.2,
                        letterSpacing: .18,
                        color: AppColors.secondaryText,
                      ),
                    )
                  ],
                ),
              ),
              const VerticalSpacer(
                space: 16,
              ),
              Text(
                testimonial.shortDescription,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .18,
                ),
              ),
              const VerticalSpacer(
                space: 12,
              ),
              HandCursorInkWell(
                onClick: () => onReadMoreClick(testimonial),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Read More',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 13,
                      ),
                    ),
                    HorizontalSpacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
