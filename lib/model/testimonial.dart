import 'package:timeago/timeago.dart' as timeago;

import '../constants/assets.dart';
import 'customer.dart';

class UserTestimonial {
  UserTestimonial({
    this.id,
    this.user,
    this.date,
    this.shortDescription,
    this.description,
    this.blogId,
    this.thumbnail,
    this.imageUrl,
  });

  final int id;
  final Customer user;
  final DateTime date;
  final String shortDescription;
  final String description;
  final int blogId;
  final String thumbnail;
  final String imageUrl;

  String get publishDate => timeago.format(date);

  static List<UserTestimonial> get list {
    return [
      UserTestimonial(
        id: 1,
        user: Customer(
          id: 1,
          firstName: 'Saffron',
          lastName: 'Trail',
        ),
        date: DateTime.now().subtract(
          const Duration(days: 2),
        ),
        shortDescription: 'Are you looking for a twist to your meal',
        description:
            '''Are you a vegetarian and looking for a twist to your meal? If the answer is yes, you need to head to Nandita's blog The Saffron Trail. All about vegetarian home cooked food, her feed is sure to give even non-vegetarians major food goals. Also a writer of the book, The Everyday Healthy Vegetarian, Nandita has leveled up the cooking game with her recipes. Nandita is definitely one of the top food influencers in India who makes our crave for mouth-watering dishes made with such precision and art.''',
        imageUrl: Assets.blogOne,
        blogId: 34,
      ),
      UserTestimonial(
        id: 2,
        user: Customer(
          id: 2,
          firstName: 'Richa',
          lastName: 'Gupta',
        ),
        date: DateTime.now().subtract(
          const Duration(days: 3),
        ),
        shortDescription:
            'Doing something that you love and turning it into your passion takes a lot of effort and confidence',
        description:
            '''Doing something that you love and turning it into your passion takes a lot of effort and confidence - We can totally say Richa Gupta nailed it when it comes to giving her readers a treat while going through her beautiful blog dedicated to scrumptious dishes. She has worked with several brands and got a huge number of followers which shows how foodies adore her feed and look forward to new posts. She's definitely one of the top food bloggers in Bangalore,you've got to follow for honest food reviews.''',
        imageUrl: Assets.blogTwo,
        blogId: 36,
      ),
      UserTestimonial(
        id: 3,
        user: Customer(
          id: 3,
          firstName: 'Nalini',
          lastName: 'Gupta',
        ),
        date: DateTime.now().subtract(
          const Duration(days: 5),
        ),
        shortDescription:
            'Nalini Gupta is not just a food blogger but also a travel and lifestyle blogger giving us some major goals as to',
        description:
            '''what to eat next or where to travel next. Her reviews are all you need to decide what you're going to eat next - one scroll through feed will take you to a foodie's paradise. We're already drooling over this chocolate popsicle! You've got to follow her to know what's new in Bangalore when looking for exquisite meals''',
        imageUrl: Assets.blogThree,
        blogId: 39,
      ),
    ];
  }
}
