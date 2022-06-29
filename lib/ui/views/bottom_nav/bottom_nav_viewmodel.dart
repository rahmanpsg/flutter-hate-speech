import 'package:flutter/material.dart';
import 'package:hate_speech_classification/app/app.locator.dart';
import 'package:hate_speech_classification/app/app.logger.dart';
import 'package:hate_speech_classification/app/app.router.dart';
import 'package:hate_speech_classification/ui/views/home/home_view.dart';
import 'package:hate_speech_classification/ui/views/klasifikasi/klasifikasi_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavViewModel extends IndexTrackingViewModel {
  final log = getLogger('BottomNavViewModel');

  final _navigationService = locator<NavigationService>();

  void handleNavigation(int index) {
    if (currentIndex == index) return;
    log.i('handleNavigation: $index');

    setIndex(index);
    switch (index) {
      case 0:
        _navigationService.replaceWithTransition(
          const HomeView(),
          transitionStyle: Transition.leftToRight,
          id: 0,
        );
        break;
      case 1:
        _navigationService.replaceWithTransition(
          const KlasifikasiView(),
          transitionStyle: Transition.rightToLeft,
          id: 0,
        );
        break;
      default:
    }
  }
}
