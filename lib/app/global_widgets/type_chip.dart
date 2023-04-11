import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class DefaultCafeTypeChip extends StatelessWidget {
  final String cafeType;
  final Color textColor;
  final Color backgroundColor;
  final bool isSelected;
  final bool? isPositionedBottom;
  final Function onTapAction;

  DefaultCafeTypeChip({
    required this.cafeType,
    required this.textColor,
    required this.backgroundColor,
    required this.onTapAction,
    this.isSelected = true,
    this.isPositionedBottom,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapAction(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  isPositionedBottom == true
                      ? 'assets/images/check.png'
                      : 'assets/images/check_filled_primary.png',
                  width: 14.0,
                  height: 14.0,
                ),
              ),
            Text(
              '$cafeType',
              style: TextStyle(
                color: textColor,
                fontSize: 14.0,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallGreyCafeTypeChip extends StatelessWidget {
  final String cafeType;

  SmallGreyCafeTypeChip({required this.cafeType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5),
      decoration: BoxDecoration(
        color: NadoColor.greyColor[200],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '$cafeType',
        style: TextStyle(
          color: NadoColor.greyColor[400],
          fontSize: 10.0,
        ),
      ),
    );
  }
}

class ColorCustomCafeTypeChip extends StatelessWidget {
  final String cafeType;
  final Color color;

  const ColorCustomCafeTypeChip({
    required this.cafeType,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '$cafeType',
        style: TextStyle(
          color: color,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
