import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.selectedColor = Colors.blue, // 選択時の色
    this.unselectedColor = Colors.grey, // 未選択時の色
  });

  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = (value == groupValue);
    final Color displayColor = isSelected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: 24, // Radioボタンのサイズ
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: displayColor, // 枠線の色
            width: 2,
          ),
        ),
        child: Center(
          child:
              isSelected
                  ? Container(
                    width: 12, // 内側の丸のサイズ
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedColor, // 選択時の内側の色
                    ),
                  )
                  : null, // 未選択時は内側の丸はなし
        ),
      ),
    );
  }
}