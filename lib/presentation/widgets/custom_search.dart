import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String? hint;
  final dynamic onChanged;
  final TextEditingController? searchController;
  const CustomSearchBar({
    super.key,
    this.hint,
    this.onChanged,
    this.searchController,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 0.1,
                offset: const Offset(0.3, 0.3)),
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 0.1,
                offset: const Offset(-0.3, -0.3)),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth / 30,
          ),
          const Icon(Icons.search),
          SizedBox(
            width: screenWidth / 30,
          ),
          Expanded(
            child: TextField(
              controller: widget.searchController,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
