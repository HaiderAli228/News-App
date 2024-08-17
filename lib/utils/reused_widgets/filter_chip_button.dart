import 'package:flutter/material.dart';

class FilterChipButton extends StatefulWidget {
  const FilterChipButton({super.key, this.title});
  final String? title;
  @override
  FilterChipButtonState createState() => FilterChipButtonState();
}

class FilterChipButtonState extends State<FilterChipButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: FilterChip(
            label: Text(
              widget.title.toString(),
              style:  TextStyle(
                  color:isSelected ? Colors.white : Colors.grey,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                isSelected = selected;
              });
            },
            selectedColor: Colors.blue,
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            checkmarkColor: Colors.white,
            labelStyle: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
        ),
        // Add more FilterChips as needed
      ],
    );
  }
}
