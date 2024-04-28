import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../../../2BL_domain/bl.dart';

// ignore: must_be_immutable
class RatingStarsPage extends StatefulWidget {
  Function setstateAattribs;
  RatingStarsPage(this.setstateAattribs, {super.key});

  @override
  State<RatingStarsPage> createState() => _RatingStarsPageState();
}

double starsValueGet() {
  if (bl.orm.currentRow.stars.value.contains('*****')) return 5;
  if (bl.orm.currentRow.stars.value.contains('****')) return 4;
  if (bl.orm.currentRow.stars.value.contains('***')) return 3;
  if (bl.orm.currentRow.stars.value.contains('**')) return 2;
  if (bl.orm.currentRow.stars.value.contains('*')) return 1;
  return 0;
}

class _RatingStarsPageState extends State<RatingStarsPage> {
  double value = starsValueGet();

  void starsValueInsert() async {
    bl.orm.currentRow.stars.value =
        bl.orm.currentRow.stars.value.replaceAll('*', '');
    if (value == 5) {
      bl.orm.currentRow.stars.value = '*****';
    }
    if (value == 4) {
      bl.orm.currentRow.stars.value = '****';
    }
    if (value == 3) {
      bl.orm.currentRow.stars.value = '***';
    }
    if (value == 2) {
      bl.orm.currentRow.stars.value = '**';
    }
    if (value == 1) {
      bl.orm.currentRow.stars.value = '*';
    }
    bl.orm.currentRow.setCellBL('stars', bl.orm.currentRow.stars.value);
    widget.setstateAattribs();
  }

  Row ratingStars() {
    return Row(
      children: [
        RatingStars(
          value: value,
          onValueChanged: (v) {
            setState(() {
              value = v;
              starsValueInsert();
            });
          },
          starBuilder: (index, color) => Icon(
            Icons.ac_unit_outlined,
            color: color,
          ),
          starCount: 5,
          starSize: 20,
          valueLabelColor: const Color(0xff9b9b9b),
          valueLabelTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 12.0),
          valueLabelRadius: 10,
          maxValue: 5,
          starSpacing: 2,
          maxValueVisibility: true,
          valueLabelVisibility: false,
          animationDuration: const Duration(milliseconds: 100),
          valueLabelPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          valueLabelMargin: const EdgeInsets.only(right: 8),
          starOffColor: const Color(0xffe7e8ea),
          starColor: Colors.yellow,
        ),
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              value = 0;
              starsValueInsert();
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ratingStars();
  }
}
