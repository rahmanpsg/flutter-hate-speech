import 'package:hate_speech_classification/services/data_service.dart';
import 'package:hate_speech_classification/services/naive_bayes.dart';
import 'package:hate_speech_classification/services/preprocessing.dart';
import 'package:hate_speech_classification/ui/views/bottom_nav/bottom_nav_view.dart';
import 'package:hate_speech_classification/ui/views/home/home_view.dart';
import 'package:hate_speech_classification/ui/views/klasifikasi/klasifikasi_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: BottomNavView, children: [
      MaterialRoute(page: HomeView, initial: true),
      MaterialRoute(page: KlasifikasiView),
    ]),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DataService),
    LazySingleton(classType: NaiveBayes),
    LazySingleton(classType: Preprocessing),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
