import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_const.dart';
import 'contact_list_controller.dart';

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  late final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(searchTextProvider);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppConst.kGray),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 26,
            color: AppConst.kGray,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextFormField(
              controller: _searchController,
              // ignore: deprecated_member_use
              onChanged: (value) =>
                  // ignore: deprecated_member_use
                  ref.read(searchTextProvider.state).state = value,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Search Contact',
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: AppConst.kGray,
                  height: 1,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
