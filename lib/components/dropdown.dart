import 'package:flutter/material.dart';

class RoleDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String?)? onChanged;
  final String? selectedItem;
  final String? hintText;

  const RoleDropdown({
    Key? key,
    required this.items,
    this.onChanged,
    this.selectedItem,
    required this.hintText,
  }) : super(key: key);

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isDense: true, // Reduce height for better fit
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 14, // Compact font size for better readability
              overflow: TextOverflow.ellipsis,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10, // Adjust vertical padding for better fit
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color.fromRGBO(27, 174, 118, 1),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color.fromRGBO(27, 174, 118, 1),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Color.fromRGBO(91, 176, 134, 1),
          ),
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
      ],
    );
  }
}
