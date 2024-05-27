import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../../2BL_domain/repos/supabase/w5filtersrepo.dart';

class StarsFavoriteUI {
  VoidCallback setStateW5;
  StarsFavoriteUI(this.setStateW5);

  ListTile starsListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          wfilterMap['stars'] = 0.0;
          setStateW5();
        },
        icon: const Icon(Icons.clear),
      ),
      title: ratingStars(),
    );
  }

  Row ratingStars() {
    return Row(
      children: [
        RatingStars(
          value: wfilterMap['stars'],
          onValueChanged: (value) {
            wfilterMap['stars'] = value;
            setStateW5();
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
      ],
    );
  }

  ListTile favListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          wfilterMap['favorite'] = '';
          setStateW5();
        },
        icon: const Icon(Icons.clear),
      ),
      title: Row(
        children: [favButt()],
      ),
    );
  }

  Widget favButt() {
    Icon favIcon = const Icon(Icons.favorite_outline);

    if (wfilterMap['favorite'] == 'f') {
      favIcon = const Icon(Icons.favorite);
    } else {
      favIcon = const Icon(Icons.favorite_outline);
    }
    return IconButton(
        icon: favIcon,
        onPressed: () async {
          if (wfilterMap['favorite'].isEmpty) {
            wfilterMap['favorite'] = 'f';
          } else {
            wfilterMap['favorite'] = '';
          }
          setStateW5();
        });
  }
}
