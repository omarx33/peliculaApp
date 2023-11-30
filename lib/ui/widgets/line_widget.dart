import 'package:flutter/material.dart';
import 'package:movie_app/ui/general/colors.dart';

class LineWidget extends StatelessWidget {
  double ancho;

  LineWidget({required this.ancho});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: 3.2,
      decoration: BoxDecoration(
        color: kBrandSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
