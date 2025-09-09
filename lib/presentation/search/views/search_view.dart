import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Search Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}