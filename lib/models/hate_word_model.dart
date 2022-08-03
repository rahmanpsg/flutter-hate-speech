class HateWordModel {
  final String text;
  final int label;

  HateWordModel({required this.text, required this.label});

  factory HateWordModel.fromJson(Map<String, dynamic> json) {
    return HateWordModel(
      text: json['text'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'label': label,
    };
  }

  @override
  String toString() {
    return 'HateWordModel{text: $text, label: $label}';
  }

  String getCategory() {
    switch (label) {
      case 1:
        return 'Ujaran Kebencian';
      default:
        return 'Bukan Ujaran Kebencian';
    }
  }
}
