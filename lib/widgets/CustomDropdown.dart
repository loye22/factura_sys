import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends FormField<String> {
  final List<String> items;
  final String? hint;
  final TextEditingController textEditingController;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final IconData hintIcon;
  final VoidCallback onAddNewItemPressed;

  CustomDropdown({
    Key? key,
    this.selectedValue,
    required this.items,
    this.hint = 'Tip',
    this.hintIcon = Icons.category,
    this.onChanged,
    required this.textEditingController,
    required this.onAddNewItemPressed,
    FormFieldValidator<String>? validator,
  }) : super(
    key: key,
    initialValue: selectedValue,
    validator: (value) {
      if (value == 'add_new') {
        return 'This value cannot be selected.';
      }
      if (value == null || value.isEmpty) {
        return "Te rog să selectezi o valoare";
      }
      return null;
    },
    builder: (FormFieldState<String> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFF444444),
                width: .7,
              ),
            ),
            padding: EdgeInsets.all(5.0),
            child: DropdownButtonHideUnderline(
              child: Builder(builder: (context) {
                double screenWidth = MediaQuery.of(context).size.width;

                return DropdownButton2<String>(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(hintIcon),
                      SizedBox(width: 8),
                      Text(
                        hint!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'add_new',
                      child: TextButton.icon(
                        onPressed: onAddNewItemPressed,
                        icon: const Icon(Icons.edit,
                            size: 18, color: Colors.blue),
                        label: const Text(
                          'Add New',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    ...items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ],
                  value: selectedValue,
                  onChanged: (value) {
                    state.didChange(value);
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: screenWidth * 0.4, // Set a reasonable width
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: screenWidth * 0.4, // Limit dropdown width
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: textEditingController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 70,
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: "Caută un articol...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue.toLowerCase());
                    },
                  ),
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  },
                );
              }),
            ),
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                state.errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      );
    },
  );
}



