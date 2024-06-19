import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DropDownMenuScreen extends StatefulWidget {
  const DropDownMenuScreen({super.key, required this.title});

  final String title;

  @override
  State<DropDownMenuScreen> createState() => _DropDownMenusState();
}

class _DropDownMenusState extends State<DropDownMenuScreen> {
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "Jatin Sharma", data: 'CSE Student'),
    OptionItem(id: "2", title: "Puneet Chand", data: 'CSE Student'),
    OptionItem(id: "3", title: "Vikas Bhardwaj", data: 'CSE Student'),
    OptionItem(id: "4", title: "Rakesh Kumar", data: 'CSE Student'),
    OptionItem(id: "5", title: "Alok Dubey", data: 'CSE Student'),
    OptionItem(id: "6", title: "Kiran Yadav", data: 'CSE Student'),
    OptionItem(id: "7", title: "Pradeep Kumar", data: 'CSE Student'),
    OptionItem(id: "8", title: "Amit Kumar", data: 'CSE Student'),
    OptionItem(id: "9", title: "Shweta Sharma", data: 'CSE Student'),
    OptionItem(id: "10", title: "Ankit Bhist", data: 'CSE Student'),
  ]);
  OptionItem optionItemSelected = OptionItem(title: "Select User");

  TextEditingController controller = TextEditingController();

  String selectedData1 = '';
  String selectedData2 = '';
  String selectedData3 = '';
  String selectedData4 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              /// Simple DropDown
              SelectDropList(
                itemSelected: optionItemSelected,
                dropListModel: dropListModel,
                showIcon: false,
                showArrowIcon: true,
                showBorder: true,
                enable: true,
                paddingTop: 0,
                paddingDropItem: const EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 20),
                suffixIcon: Icons.arrow_drop_down,
                containerPadding: const EdgeInsets.all(10),
                icon: const Icon(Icons.person, color: Colors.black),
                onOptionSelected: (optionItem) {
                  setState(() {
                    optionItemSelected = optionItem;
                    selectedData1 = 'Selected: ${optionItem.title}';
                  });
                },
              ),

              /// Search DropDown
              SearchDropList(
                itemSelected: optionItemSelected,
                dropListModel: dropListModel,
                showIcon: false,
                showArrowIcon: true,
                showBorder: true,
                enable: true,
                textEditingController: controller,
                paddingTop: 0,
                suffixIcon: Icons.arrow_drop_down,
                containerPadding: const EdgeInsets.all(10),
                icon: const Icon(Icons.person, color: Colors.black),
                onOptionSelected: (optionItem) {
                  setState(() {
                    optionItemSelected = optionItem;
                    selectedData2 = 'Selected: ${optionItem.title}';
                    if (kDebugMode) {
                      print(optionItemSelected.id);
                    }
                  });
                },
              ),

              /// Multiple Selection DropDown
              SelectDropMultipleList(
                defaultText: optionItemSelected,
                dropListModel: dropListModel,
                showIcon: false,
                showBorder: true,
                enable: true,
                paddingTop: 0,
                submitText: "OK",
                onTapCross: (data) {
                  if (data) {
                    print("List Clear");
                  }
                },
                colorSubmitButton: Colors.amber,
                selectedIconWidget: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.amber),
                  child: const Icon(
                    Icons.done,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                suffixIcon: Icons.arrow_drop_down,
                containerPadding: const EdgeInsets.all(10),
                icon: const Icon(Icons.person, color: Colors.black),
                onOptionListSelected: (list) {
                  setState(() {
                    selectedData3 =
                        'Selected: ${list.map((item) => item.title).join(', \n')}';
                    for (var data in list) {
                      if (data.id != null) {
                        if (kDebugMode) {
                          print(data.id);
                        }
                      }
                    }
                  });
                },
              ),

              /// Radio Selection DropDown
              SelectDropRadio(
                defaultText: optionItemSelected,
                dropListModel: dropListModel,
                showIcon: false,
                showBorder: true,
                paddingTop: 0,
                enable: true,
                submitText: "OK",
                colorSubmitButton: Colors.black,
                selectedRadioColor: Colors.green,
                suffixIcon: Icons.arrow_drop_down,
                containerPadding: const EdgeInsets.all(10),
                icon: const Icon(Icons.person, color: Colors.black),
                onOptionListSelected: (data) {
                  setState(() {
                    selectedData4 = 'Selected: ${data.title}';
                    print(data.title);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Selected data1 is: $selectedData1\n'
                  'Selected data2 is: $selectedData2\n'
                  'Selected data3 is: $selectedData3\n'
                  'Selected data4 is: $selectedData4',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
