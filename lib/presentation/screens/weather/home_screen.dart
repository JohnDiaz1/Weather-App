import 'package:flutter/material.dart';
import 'package:weather_app/presentation/views/views.dart';
import 'package:weather_app/presentation/views/weather/favorites_view.dart';
import 'package:weather_app/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final viewRoutes = <Widget>[
    const HomeView(),
    const CurrentForecastView(),
    const MapView(),
    const FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if ( pageController.hasClients ) {
      pageController.animateToPage(
          widget.pageIndex,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut
      );
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;

}

