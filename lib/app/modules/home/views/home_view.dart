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
                    // 1. Prepate your data
                    List<String> options = ['Apple', 'Bebek', 'Ayam', 'Bubur', 'Nasi Goreng', 'Capuchino', 'Mango', 'Banana', 'Pizza', 'Iga Bakar'];

                    // 2. Call widget
                    SelectOptionWidget(options: options).open((String? value) {
                      logg(value);
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
