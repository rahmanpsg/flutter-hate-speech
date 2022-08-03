import 'package:flutter/material.dart';
import 'package:hate_speech_classification/themes/app_colors.dart';
import 'package:hate_speech_classification/themes/app_text.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: secondaryColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Selamat datang di aplikasi Hate Speech Classification (HSC). Menggunakan metode naive bayes untuk mengklasifikasi kalimat yang mengandung kata-kata yang tidak bijak.',
                    style: regularTextStyle.copyWith(color: lightColor),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: secondaryColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          'Daftar Kata-kata yang tidak bijak',
                          style: mediumTextStyle,
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: mainColor,
                        ),
                        Expanded(
                          child: Scrollbar(
                            thickness: 10,
                            radius: const Radius.circular(8),
                            child: ListView.separated(
                              itemCount: model.hateWords.length,
                              itemBuilder: (BuildContext context, int index) {
                                final hateWord = model.hateWords[index];

                                return ListTile(
                                  leading: Text(
                                    "${index + 1}",
                                    style: regularTextStyle,
                                  ),
                                  title: Text(
                                    hateWord.text,
                                    style: regularTextStyle,
                                  ),
                                  trailing: SizedBox(
                                    width: 50,
                                    child: Text(
                                      hateWord.getCategory(),
                                      style: regularTextStyle.copyWith(
                                        color: hateWord.label == 1
                                            ? dangerColor
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (_, index) => const Divider(
                                color: lightGreyColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
