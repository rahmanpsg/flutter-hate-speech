import 'package:flutter/material.dart';
import 'package:hate_speech_classification/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'bottom_nav_viewmodel.dart';

class BottomNavView extends StatelessWidget {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavViewModel>.reactive(
      viewModelBuilder: () => BottomNavViewModel(),
      builder: (
        BuildContext context,
        BottomNavViewModel viewModel,
        Widget? child,
      ) {
        return Scaffold(
            appBar: AppBar(title: const Text('Hate Speech Classification')),
            body: ExtendedNavigator(
              navigatorKey: StackedService.nestedNavigationKey(0),
              router: BottomNavViewRouter(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 6,
              currentIndex: viewModel.currentIndex,
              onTap: viewModel.handleNavigation,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Klasifikasi',
                ),
              ],
            ));
      },
    );
  }
}
