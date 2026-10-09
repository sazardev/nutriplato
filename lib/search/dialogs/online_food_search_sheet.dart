import 'package:flutter/material.dart';

import '../online_food_search.dart';

void showOnlineSearchSheet(BuildContext context, {String initialQuery = ''}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => OnlineFoodSearchSheet(initialQuery: initialQuery),
  );
}
