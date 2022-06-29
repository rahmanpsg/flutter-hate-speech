import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hate_speech_classification/app/app.locator.dart';
import 'package:hate_speech_classification/app/app.logger.dart';
import 'package:hate_speech_classification/services/naive_bayes.dart';
import 'package:hate_speech_classification/services/preprocessing.dart';
import 'package:stacked/stacked.dart';

class KlasifikasiViewModel extends BaseViewModel {
  final log = getLogger('KlasifikasiViewModel');
  final _naiveBayes = locator<NaiveBayes>();
  final _preprocessing = locator<Preprocessing>();

  final textController = TextEditingController();

  String? result;
  List<dynamic>? probabilities;

  void paste() async {
    textController.text =
        (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? '';
  }

  void clear() {
    textController.clear();
    result = null;
    probabilities = null;

    notifyListeners();
  }

  void onSubmit() async {
    if (textController.text.isEmpty) return;

    setBusy(true);
    final tokens =
        (await _preprocessing.preprocess(textController.text)).split(' ');

    final r = _naiveBayes.frequencyTable(tokens);

    result = _naiveBayes.categorize(tokens);
    probabilities = _naiveBayes.probabilities(tokens);

    probabilities?.sort((a, b) => b['value'].compareTo(a['value']));

    log.i(tokens);
    log.i(probabilities);
    log.i(result);
    log.i(r);
    setBusy(false);
  }
}
