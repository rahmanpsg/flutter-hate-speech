import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hate_speech_classification/app/app.locator.dart';
import 'package:hate_speech_classification/app/app.logger.dart';
import 'package:hate_speech_classification/models/hate_word_model.dart';
import 'package:hate_speech_classification/services/naive_bayes.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class DataService with ReactiveServiceMixin {
  final log = getLogger('DataService');

  static const _dataPath = 'assets/data/data.json';
  static const _datasetPath = 'assets/data/dataset.json';
  static Box? _box;

  final NaiveBayes _naiveBayes = locator<NaiveBayes>();
  // final Preprocessing _preprocessing = locator<Preprocessing>();

  // List<HateWordModel> _hateWords = [];
  final ReactiveList<HateWordModel> _hateWords = ReactiveList<HateWordModel>();

  DataService() {
    listenToReactiveValues([_hateWords]);
  }

  Future<void> syncData() async {
    log.i('load data...');
    _box ??= await Hive.openBox('dataset');

    if (_box?.isEmpty == true) {
      // load data json from asset
      final jsonDataString = await rootBundle.loadString(_dataPath);
      _naiveBayes.fromJson(jsonDataString);

      final jsonDatasetString = await rootBundle.loadString(_datasetPath);
      final dataset = json.decode(jsonDatasetString);

      _hateWords.addAll(List.generate(
          dataset.length, (index) => HateWordModel.fromJson(dataset[index])));

      // save data to hive
      // _box?.clear();
      // _box?.put('dataset', dataset);

      log.i('data loaded');
    }
  }

  String getCategory(int index) {
    switch (index) {
      case 1:
        return 'Lemah';
      case 2:
        return 'Menengah';
      case 3:
        return 'Kuat';
      default:
        return 'Bukan';
    }
  }

  List<HateWordModel> get hateWords => _hateWords;
}
