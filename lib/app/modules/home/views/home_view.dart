import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixins/mixins.dart';
import 'package:reusable_text_input/app/widget/custom_widget.dart';
import 'package:reusable_text_input/app/widget/select_option_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Date Picker
              TextInput(
                label: 'Date Picker',
                backgroundColor: Colors.black12,
                icon: Icons.calendar_today,
                hint: 'Select Date',
                autofocus: false,
                colorIcon: Colors.black,
                onSelect: ((val) {
                  TextInput.datePicker(context, onSelect: ((val) {
                    print(val);
                  }));
                }),
              ),
              // Time Picker
              TextInput(
                label: 'Time Picker',
                backgroundColor: Colors.black12,
                icon: Icons.watch_later,
                hint: 'Select Date',
                colorIcon: Colors.black,
                onSelect: ((val) {
                  TextInput.timePicker(context, onSelect: ((val) {
                    print(val);
                  }));
                }),
              ),
              // TextInput
              TextInput(
                label: 'Text Input',
                backgroundColor: Colors.black12,
                icon: Icons.file_copy,
                hint: 'Select Date',
                colorIcon: Colors.black,
              ),

              // DropDown Picker

              TextInput(
                  label: 'DropDown',
                  backgroundColor: Colors.black12,
                  icon: Icons.arrow_drop_down,
                  hint: 'Select Date',
                  colorIcon: Colors.black,
                  onSelect: ((val) {
                    TextInput.dropDownPicker(
                      options: List.generate(10, (i) => 'Option $i'),
                      onSelect: ((val) {
                        logg(val, color: 'g');
                      }),
                    );
                  })),
              TextInput(
                  label: 'DropDown Search',
                  backgroundColor: Colors.black12,
                  icon: Icons.arrow_drop_down,
                  hint: 'Select Date',
                  colorIcon: Colors.black,
                  onSelect: ((val) {
                    // TextInput.dropDownsearch();

                    // Usage:
                    // Misalkan kamu punya data seperti ini yang kamu dapat dari response api,
                    // Atau kamu punya data berupa List<NamaModel>
                    // List<Map> data = [
                    //   { 'id': 1, 'item': 'Apple', 'enable': true },
                    //   { 'id': 2, 'item': 'Bebek', 'enable': true },
                    //   { 'id': 3, 'item': 'Ayam', 'enable': false },
                    //   { 'id': 4, 'item': 'Bubur', 'enable': true },
                    //   { 'id': 5, 'item': 'Nasi Goreng', 'enable': false },
                    //   { 'id': 6, 'item': 'Capuchino', 'enable': true },
                    //   { 'id': 7, 'item': 'Mango', 'enable': false },
                    //   { 'id': 8, 'item': 'Banana', 'enable': true },
                    //   { 'id': 9, 'item': 'Pizza', 'enable': true },
                    //   { 'id': 10, 'item': 'Iga Bakar', 'enable': true },
                    // ];

                    List<ItemModel> data = [
                      ItemModel(id: 1, item: 'Apple', enable: true),
                      ItemModel(id: 2, item: 'Bebek', enable: true),
                      ItemModel(id: 3, item: 'Ayam', enable: false),
                      ItemModel(id: 4, item: 'Bubur', enable: true),
                      ItemModel(id: 5, item: 'Nasi Goreng', enable: false),
                      ItemModel(id: 6, item: 'Capuchino', enable: false),
                      ItemModel(id: 7, item: 'Mango', enable: true),
                      ItemModel(id: 8, item: 'Pizza', enable: true),
                    ];

                    // 1. Get option yang ingin kamu tampilkan
                    List<String> options = [...data.map((e) => e.item!)];

                    // 2. Get value (unique)
                    List<int> values = [...data.map((e) => e.id!)];

                    // 3. Set enable/disabled option
                    List<bool> disabled = [...data.map((e) => e.enable ?? false)];

                    // 2. Call widget
                    SelectOptionWidget(options: options, values: values, disabled: disabled).open((String? o, v) {
                      ItemModel? result = data.firstWhere((e) => e.id == v, orElse: () => ItemModel());
                      if (result.id != null) {
                        // Do something!
                      }
                    });
                  })),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemModel {
  final int? id;
  final String? item;
  final bool? enable;

  ItemModel({this.id, this.item, this.enable});
}
