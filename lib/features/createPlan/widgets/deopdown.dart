import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String labelText;

  const SearchableDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredItems = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) =>
              item["Exercise_Name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Search ${widget.labelText}",
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _searchController.clear();
                    _filterItems('');
                  }
                  _isSearching = !_isSearching;
                });
              },
            ),
          ),
          onChanged: _filterItems,
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.grey[900],
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          value: widget.value,
          items: _filteredItems.map<DropdownMenuItem<String>>((exercise) {
            return DropdownMenuItem<String>(
              value: exercise["Exercise_Name"],
              child: Text(exercise["Exercise_Name"].toString().substring(
                  0,
                  exercise["Exercise_Name"].toString().length > 20
                      ? 20
                      : exercise["Exercise_Name"].toString().length)),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
