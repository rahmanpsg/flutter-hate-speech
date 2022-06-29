import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:snowball_stemmer/snowball_stemmer.dart';

class Preprocessing {
  static final SnowballStemmer _stemmer = SnowballStemmer(Algorithm.indonesian);

  Future<String> preprocess(String text) async {
    text = _removeUrl(text);
    text = _removePunc(text);
    text = _caseFolding(text);
    Iterable<String> texts = await _removeStopWord(text);
    text = _stemming(texts);

    return text;
  }

  static String _removeUrl(String text) {
    return text.replaceAll(RegExp(r"https?://\S+|www\.\S+"), '');
  }

  static String _removePunc(String text) {
    return text.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  static String _caseFolding(String text) {
    return text.toLowerCase();
  }

  static Future<Iterable<String>> _removeStopWord(String text) async {
    // load file json assets
    final stopWords = json.decode(
      await rootBundle.loadString('assets/data/stopwords.json'),
    );

    return text.split(' ').where((word) => !stopWords.contains(word));
  }

  static String _stemming(Iterable<String> texts) {
    return texts.map((e) => _stemmer.stem(e)).join(' ');
  }
}
