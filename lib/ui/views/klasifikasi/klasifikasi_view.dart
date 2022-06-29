import 'package:flutter/material.dart';
import 'package:hate_speech_classification/themes/app_colors.dart';
import 'package:hate_speech_classification/themes/app_text.dart';
import 'package:hate_speech_classification/ui/views/widgets/custom_textfield_outline.dart';
import 'package:stacked/stacked.dart';

import 'klasifikasi_viewmodel.dart';

class KlasifikasiView extends StatelessWidget {
  const KlasifikasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KlasifikasiViewModel>.reactive(
      viewModelBuilder: () => KlasifikasiViewModel(),
      builder: (
        BuildContext context,
        KlasifikasiViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomTextFieldOutline(
                        controller: model.textController,
                        hintText:
                            'Masukkan kalimat yang ingin diklasifikasi...',
                        maxLines: 5,
                        outlineColor: mainColor,
                      ),
                    ),
                    IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: model.paste,
                            icon: const Icon(Icons.paste),
                          ),
                          IconButton(
                            onPressed: model.clear,
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: model.isBusy ? null : model.onSubmit,
                  icon: model.isBusy
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        )
                      : const Icon(Icons.manage_search),
                  label: const Text(
                    'Klasifikasi',
                  ),
                ),
                const SizedBox(height: 24),
                if (model.result != null)
                  Card(
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 1,
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Hasil Klasifikasi',
                            style: mediumTextStyle.copyWith(fontSize: 24),
                          ),
                          const Divider(color: Colors.white),
                          Text(
                            model.result ?? '-',
                            style: boldTextStyle.copyWith(fontSize: 32),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                if (model.probabilities != null)
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 1,
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Kategori',
                                style: mediumTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                              trailing: Text(
                                'Probabilitas',
                                style: mediumTextStyle.copyWith(
                                    color: Colors.black),
                              ),
                            ),
                            const Divider(),
                            ListView.builder(
                              itemCount: model.probabilities?.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  title: Text(model.probabilities?[index]
                                          ['category'] ??
                                      ''),
                                  trailing: Text(model.probabilities?[index]
                                              ['value']
                                          .toString() ??
                                      ''),
                                );
                              }),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
          ),
        );
      },
    );
  }
}
