import 'package:flutter/material.dart';

class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SearchBar(
        backgroundColor: WidgetStatePropertyAll(Color(0xffF6F6F6)),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
        leading: Icon(Icons.search_outlined, color: Colors.black),
      ),
    );
  }
}
