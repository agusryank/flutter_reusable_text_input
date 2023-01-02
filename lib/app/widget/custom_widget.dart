import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mixins/mixins.dart';
import 'package:reusable_text_input/app/theme/color_theme.dart';
import 'package:reusable_text_input/app/theme/text_theme.dart';

// ============================================================
// Custom TextInput
// ============================================================
class TextInputPickerWidget extends StatelessWidget {
  final List<String> options;
  final List? values;
  final Function(Map)? onSelect;
  final String? initialValue;

  const TextInputPickerWidget(
      {Key? key,
      this.options = const [],
      this.values,
      this.onSelect,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = options.indexWhere((e) => e == initialValue);
    i = i == -1 ? 0 : i;

    Map result = values == null
        ? {'option': options.isEmpty ? null : options[i]}
        : {
            'option': options.isEmpty ? null : options[i],
            'value': values == null || values!.isEmpty ? null : values![i]
          };

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: Br.radius(10),
        child: Container(
          height: 300,
          // The Bottom margin is provided to align the popup above the system navigation bar.
          // margin: EdgeInsets.only(
          //   bottom: MediaQuery.of(context).viewInsets.bottom,
          // ),
          // Provide a background color for the popup.
          // color: CupertinoColors.systemBackground.resolveFrom(context),
          color: Colors.white,
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoPicker(
                      magnification: 1,
                      useMagnifier: true,
                      itemExtent: 40,
                      scrollController:
                          FixedExtentScrollController(initialItem: i),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        if (onSelect != null) {
                          if (values != null) {
                            result = {
                              'option': options[selectedItem],
                              'value': values![selectedItem]
                            };
                          } else {
                            result = {'option': options[selectedItem]};
                          }
                        }
                      },
                      children:
                          List<Widget>.generate(options.length, (int index) {
                        return Center(
                          child: Text(
                            options[index],
                            style: gfont.copyWith(
                                fontSize: 17, color: Colors.white),
                          ),
                        );
                      })),
                ),
                InkW(
                    onTap: () {
                      if (onSelect != null) {
                        onSelect!(result);
                        Get.back();
                      }
                    },
                    margin: Ei.only(b: 15),
                    color: Colors.yellow.withOpacity(.1),
                    padding: Ei.sym(v: 10, h: 45),
                    child: Text('Confirm',
                        style: Gfont.bold.copyWith(color: Colors.yellow)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final String? hint;
  final dynamic Function(Map<dynamic, dynamic>)? onSelected;
  final List<String> options;
  final String? initialValue;
  final List? values;

  const CustomDropDown(
      {Key? key,
      this.hint,
      this.values,
      this.onSelected,
      this.options = const [],
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = options.indexWhere((e) => e == initialValue);
    i = i == -1 ? 0 : i;

    Map result = values == null
        ? {'option': options.isEmpty ? null : options[i]}
        : {
            'option': options.isEmpty ? null : options[i],
            'value': values == null || values!.isEmpty ? null : values![i]
          };
    return SingleChildScrollView(
      child: InkW(
        onTap: (() {
          logg('onTap');
          if (onSelected != null) {
            onSelected!(result);
            Get.back();
          }
          Get.back();
        }),
        child: Container(
          padding: Ei.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12.withOpacity(.3))),
          child: Column(
            children: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                alignment: AlignmentDirectional.topCenter,
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomDropDownSearch extends StatelessWidget {
  final bool Function(Map<String, dynamic>)? disabledItemFn;
  final List<Map<String, dynamic>> item;
  final String? hintText, tittle;
  final Map<String, dynamic>? value;
  final Function(Object?)? onChanged;
  final Color? suffixColor;
  final bool spaceBottom, enabled;
  final Future<bool?> Function(Map<String, dynamic>?)? onBeforePopupOpening;
  final Widget Function(BuildContext, Map<String, dynamic>?, bool)? itemBuilder;
  const CustomDropDownSearch(
      {Key? key,
      this.disabledItemFn,
      required this.item,
      this.hintText,
      this.tittle,
      this.enabled: true,
      this.onChanged,
      this.suffixColor,
      this.spaceBottom: false,
      this.itemBuilder,
      this.onBeforePopupOpening,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: Caa.start,
        children: [
          tittle != null
              ? Textr(
                  tittle ?? '',
                  style: gfont.copyWith(fontSize: 16, color: Colors.black),
                  margin: Ei.only(b: 5),
                )
              : None(),
          Container(
            padding: Ei.only(l: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Br.all(Colors.black)),
            child: DropdownSearch<Map<String, dynamic>>(
              enabled: enabled,
              dropdownButtonProps: DropdownButtonProps(
                icon: Container(
                  margin: Ei.only(r: 10),
                  child: Icon(
                    Icons.expand_more,
                    color: suffixColor ?? Colors.black,
                  ),
                ),
              ),
              popupProps: PopupProps.dialog(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: hintText ?? 'Ketik Disini Untuk Mencari',
                    hintStyle:
                        gfont.copyWith(fontSize: 14, color: Colors.black12),
                    contentPadding: Ei.only(l: 10, r: 10, t: 10, b: 10),
                  ),
                ),
                disabledItemFn: disabledItemFn,
                itemBuilder: itemBuilder,
              ),
              items: item,
              onBeforePopupOpening: onBeforePopupOpening,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              onChanged: onChanged,
              selectedItem: value,
            ),
          ),
          spaceBottom
              ? SizedBox(
                  height: 20,
                )
              : None()
        ],
      ),
    );
  }
}

class InputControlListener extends GetxController {}

class TextInputTransparent extends StatelessWidget {
  final String? hint, initialValue;
  final TextInputType? keyboard;
  final TextInputAction? inputAction;
  final Function(String)? onSubmit, onChanged;
  final bool autofocus, enabled, obsecure, showMaxLength;
  final FocusNode? node;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final int? maxLength, maxLines;
  final List<TextInputFormatter> formatters;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle, hintStyle;

  TextInputTransparent(
      {this.hint,
      this.keyboard,
      this.inputAction,
      this.onSubmit,
      this.obsecure: false,
      this.onChanged,
      this.autofocus: false,
      this.showMaxLength: false,
      this.node,
      this.controller,
      this.initialValue,
      this.textAlign,
      this.enabled: true,
      this.maxLength: 255,
      this.formatters: const [],
      this.contentPadding,
      this.maxLines,
      this.textStyle,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    Widget textField = TextFormField(
      style: textStyle ?? Gfont.black7,
      keyboardType: keyboard,
      textInputAction: inputAction,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      initialValue: initialValue,
      autofocus: autofocus,
      focusNode: node,
      obscureText: obsecure,
      enabled: enabled,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      maxLines: maxLines == null ? 1 : maxLines,
      minLines: 1,
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)]
        ..addAll(formatters),
      decoration: InputDecoration(
        contentPadding: contentPadding ?? Ei.sym(v: 13.5),
        hintText: hint,
        hintStyle: hintStyle ??
            Gfont.black.copyWith(fontSize: 15, color: Colors.black38),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );

    return textField;
  }
}

class TextInput extends StatelessWidget {
  final String label;
  final String? initialValue;
  final IconData? icon;
  final String? hint;
  final bool obsecure, autofocus, enabled;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLength;
  final FocusNode? node;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Function(TextEditingController? formControl)? onSelect;
  final Function(String)? onSubmit, onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter> formatters;
  final Color? backgroundColor, colorIcon;

  const TextInput(
      {Key? key,
      required this.label,
      this.icon,
      this.hint,
      this.obsecure = false,
      this.autofocus = false,
      this.suffixIcon,
      this.keyboardType,
      this.maxLength = 50,
      this.node,
      this.initialValue,
      this.colorIcon,
      this.enabled = true,
      this.borderRadius,
      this.margin,
      this.onSelect,
      this.onSubmit,
      this.onChanged,
      this.controller,
      this.backgroundColor,
      this.formatters = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? Ei.only(b: 15),
        child: ClipRRect(
          borderRadius: borderRadius ?? Br.radius(10),
          child: InkW(
            onTap: onSelect == null
                ? null
                : () {
                    if (onSelect != null) onSelect!(controller);
                  },
            color: backgroundColor ?? Colors.white,
            child: Container(
              padding: Ei.only(l: 15, r: 15, t: 15, b: 10),
              child: Col(children: [
                Textr(label, margin: Ei.only(b: 2, l: 0), style: Gfont.fs13),
                SizedBox(
                    child: Row(
                  children: [
                    Expanded(
                      child: Row(children: [
                        icon == null
                            ? None()
                            : Iconr(icon!,
                                color: colorIcon,
                                margin: Ei.only(r: 15, b: 15)),
                        Expanded(
                            child: TextInputTransparent(
                          hint: hint,
                          keyboard: keyboardType ?? Tit.text,
                          maxLength: maxLength,
                          initialValue: initialValue,
                          node: node,
                          enabled: enabled && onSelect == null,
                          obsecure: obsecure,
                          autofocus: autofocus,
                          onSubmit: onSubmit,
                          onChanged: onChanged,
                          controller: controller,
                          formatters: formatters,
                          hintStyle: TextStyle(color: Colors.black),
                          // textStyle: TextStyle(color: AppThemeColor.primary),
                          contentPadding: Ei.sym(v: 5),
                        )),
                      ]),
                    ),
                    suffixIcon ?? None(),
                    onSelect == null || suffixIcon == null
                        ? None()
                        : const Icon(
                            Icons.expand_more,
                            size: 15,
                          )
                  ],
                ))
              ]),
            ),
          ),
        ));
  }
  // ===========================================================
  // this methods is to set border radius only
  // ===========================================================

  /// top left-right radius
  static tlrRadius([double value = 10]) => BorderRadius.only(
      topLeft: Radius.circular(value), topRight: Radius.circular(value));

  /// bottom left-right radius
  static blrRadius([double value = 10]) => BorderRadius.only(
      bottomLeft: Radius.circular(value), bottomRight: Radius.circular(value));

  // ===========================================================
  // easy way to open cupertino picker
  // ===========================================================

  /// ```dart
  /// // with list of string
  /// List<String> options = ['option1', 'option2', 'option3'];
  /// TextInput.picker(options: options);
  ///
  /// // with list of objects
  /// List<Map> data = [{"city": "Denpasar", "id": 1}];
  /// List<String> options = data.map((e) => e['city']).toList();
  /// List values = data.map((e) => e['id']).toList();
  /// TextInput.picker(options: options, values: values);
  ///
  /// // onSelect property return a map with key 'option' and value 'value'
  /// ```

  static picker(
      {String? initialValue,
      List<String> options = const [],
      List? values,
      Function(Map)? onSelect}) {
    ;

    Get.bottomSheet(ScrollConfiguration(
        behavior: NoScrollGlow(),
        child: TextInputPickerWidget(
            initialValue: initialValue,
            options: options,
            values: values,
            onSelect: onSelect)));
  }

  static dropDownPicker(
      {String? initialValue,
      List<String> options = const [],
      List? values,
      dynamic Function(Map<dynamic, dynamic>)? onSelect}) {
    ;

    Get.bottomSheet(CustomDropDown(
        initialValue: initialValue, options: options, onSelected: onSelect));
  }

  static dropDownsearch(
      {String? initialValue,
      List<Map<String, dynamic>> options = const [],
      List? values,
      dynamic Function(Map<dynamic, dynamic>)? onSelect}) {
    Get.bottomSheet(CustomDropDownSearch(
      item: options,
    ));
  }

  static datePicker(context,
      {DateTime? initialDate,
      DateTime? firstDate,
      DateTime? lastDate,
      DatePickerEntryMode? entryMode,
      Function(DateTime)? onSelect}) async {
    try {
      showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? DateTime(2050),
          initialEntryMode: entryMode ?? DatePickerEntryMode.calendar,
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                  textTheme: TextTheme(
                      bodyText1: TextStyle(color: primaryColor),
                      headline4: TextStyle(fontSize: 30, color: primaryColor)),
                  colorScheme: ColorScheme.light(primary: primaryColor),
                ),
                child: child!);
          }).then((date) {
        if (date != null && onSelect != null) {
          onSelect(date);
        }
      });
    } catch (e, s) {
      Mixins.errorCatcher(e, s);
    }
  }

  static timePicker(context,
      {TimeOfDay? initialTime, Function(TimeOfDay)? onSelect}) async {
    try {
      await showTimePicker(
          context: context,
          initialTime: initialTime ?? TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          }).then((time) {
        if (time != null && onSelect != null) {
          onSelect(time);
        }
      });
    } catch (e, s) {
      Mixins.errorCatcher(e, s);
    }
  }

  static Widget radio(
      {String? label,
      List options = const [],
      TextEditingController? controller,
      Function(Object?)? onChanged}) {
    return Container(
      width: Get.width,
      child: Col(
        children: [
          Textr(
            '$label',
            margin: Ei.only(b: 2, l: 0, t: 10),
            style: Gfont.black.copyWith(
              fontSize: 16,
            ),
          ),
          Wrap(
            children: List.generate(
              options.length,
              (i) {
                String option = options[i];

                return Container(
                  margin: Ei.only(r: 15, b: 10),
                  child: Touch(
                    onTap: onChanged == null ? null : () => onChanged(option),
                    child: Row(
                      mainAxisSize: Mas.min,
                      children: [
                        Radio(
                            value: option,
                            groupValue: controller?.text,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity + 3),
                            activeColor: Colors.blue,
                            onChanged: onChanged),
                        Textr(
                          options[i],
                          margin: Ei.only(l: 5),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TextInputGroup extends StatelessWidget {
  final List children;
  final EdgeInsetsGeometry? margin;
  final Textr? label;
  final IconData? icon;

  const TextInputGroup(
      {Key? key, this.label, this.children = const [], this.margin, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? Ei.only(b: 10, t: 10),
      child: Column(
        children: [
          label == null
              ? None()
              : Container(
                  margin: Ei.only(b: 15),
                  child: Row(
                    children: [
                      icon == null
                          ? None()
                          : Iconr(icon!, margin: Ei.only(r: 15)),
                      label!,
                    ],
                  ),
                ),
          Column(
            mainAxisAlignment: Maa.start,
            crossAxisAlignment: Caa.start,
            children: List.generate(children.length, (i) {
              if (children[i] is! TextInput) {
                return children[i];
              }

              TextInput t = children[i];

              return TextInput(
                label: t.label,
                hint: t.hint,
                icon: t.icon,
                keyboardType: t.keyboardType,
                maxLength: t.maxLength,
                onSelect: t.onSelect,
                controller: t.controller,
                margin: t.margin,
                enabled: t.enabled,
                suffixIcon: t.suffixIcon,
                obsecure: t.obsecure,
                formatters: t.formatters,
                onChanged: t.onChanged,
                onSubmit: t.onSubmit,
                borderRadius: children.length == 1
                    ? Br.radius(10)
                    : i == 0
                        ? TextInput.tlrRadius()
                        : i == children.length - 1
                            ? TextInput.blrRadius()
                            : Br.radius(0),
              );
            }),
          ),
        ],
      ),
    );
  }
}
