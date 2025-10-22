import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const FilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final List<String> categories = const [
    'All',
    'Menstrual Health',
    'Pregnancy',
    'Cancer Awareness',
    'Mental Wellness',
    'Education',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final isSelected = selectedFilter == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) => onFilterSelected(category),
                backgroundColor: Colors.white,
                selectedColor: Colors.pink.shade100,
                checkmarkColor: Colors.pink.shade800,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.pink.shade800 : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                side: BorderSide(
                  color: isSelected ? Colors.pink.shade300 : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}