import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mixins/mixins.dart';
import 'package:reusable_text_input/app/theme/text_theme.dart';
import 'package:reusable_text_input/app/widget/custom_widget.dart';

class SelectOptionNotifier extends ValueNotifier {
  SelectOptionNotifier(String super.value);

  String keyword = '';

  void filter(String value) {
    keyword = value;
    // logg(keyword);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SelectOptionWidget extends StatelessWidget {
  final List<String> options;
  const SelectOptionWidget({super.key, this.options = const []});

  @override
  Widget build(BuildContext context) {
    SelectOptionNotifier notifier = SelectOptionNotifier('');

    Widget childList = ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, __) {
          List<String> list = options;
          String keyword = notifier.keyword;

          list = options.where((e) => e.toLowerCase().contains(keyword.toLowerCase())).toList();

          return Col(
              children: List.generate(list.length, (i) {
            String option = list[i];

            return InkW(
              onTap: () {
                context.pop(option);
              },
              padding: Ei.all(20),
              child: Container(
                child: Row(
                  children: [
                    Text(option),
                  ],
                ),
              ),
            );
          }));
        });

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: Ei.only(t: 30),
            child: Row(
              mainAxisAlignment: Maa.spaceBetween,
              children: [
                Textr(
                  'Pilih Sesuatu',
                  style: Gfont.fs20,
                  margin: Ei.only(l: 20),
                ),
                Touch(onTap: () => context.pop(), child: Iconr(La.times, color: Colors.black54, size: 22, padding: Ei.all(20)))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BounceScroll(),
              child: childList,
            ),
          ),
          Container(
            padding: Ei.sym(h: 20, v: 5),
            decoration: BoxDecoration(border: Br.only(['t', 'b'])),
            child: TextInputTransparent(
                hint: 'Ketik untuk mencari',
                onChanged: (String keyword) {
                  notifier.filter(keyword);
                }),
          )
        ],
      ),
    );
  }

  open([Function(String? value)? onSelect]) async {
    Get.bottomSheet(this, isScrollControlled: true).then((value) => onSelect?.call(value));
  }
}
