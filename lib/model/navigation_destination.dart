import '../constants/assets.dart';
import '../constants/strings.dart';

class NavigationDestination {
  NavigationDestination({this.title, this.icon, this.selected = false});
  final String title;
  final String icon;
  bool selected;

  static List<NavigationDestination> get list {
    return [
      NavigationDestination(
        title: Strings.overview,
        icon: Assets.overviewPng,
      ),
      NavigationDestination(
        title: Strings.menu,
        icon: Assets.menuPng,
      ),
      NavigationDestination(
        title: Strings.transaction,
        icon: Assets.transactionPng,
      ),
      NavigationDestination(
        title: Strings.calendar,
        icon: Assets.calendarPng,
      ),
      NavigationDestination(
        title: Strings.testimonials,
        icon: Assets.testimonialPng,
      ),
      NavigationDestination(
        title: Strings.faq,
        icon: Assets.faqPng,
      ),
    ];
  }
}
