import '../constants/route_names.dart';
import '../features/add_page/add_page.dart';
import '../features/detail_page/detail_page.dart';
import '../features/home_page/home_page.dart';

class AppRoutes {
  static final routes = {
    RouteNames.homePage: (context) => const HomePage(title: 'Contact List App'),
    RouteNames.addPage: (context) => const AddPage(),
    RouteNames.detailPage: (context) => const DetailPage(),
  };
}
