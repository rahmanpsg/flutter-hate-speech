import 'package:hate_speech_classification/app/app.locator.dart';
import 'package:hate_speech_classification/app/app.logger.dart';
import 'package:hate_speech_classification/models/hate_word_model.dart';
import 'package:hate_speech_classification/services/data_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends ReactiveViewModel {
  final log = getLogger('HomeViewModel');
  final _dataService = locator<DataService>();

  List<HateWordModel> get hateWords => _dataService.hateWords;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dataService];
}
