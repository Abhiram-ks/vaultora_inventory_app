import 'package:flutter/material.dart';

import '../../../../db/helpers/salefuction.dart';

class SearchbarSale extends StatefulWidget {
  final String hintText;
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;
  final bool isFilterActive;

  const SearchbarSale({
    super.key,
    required this.hintText,
    required this.onSearchPressed,
    required this.onFilterPressed,
    required this.isFilterActive,
  });

  @override
  State<SearchbarSale> createState() => _SearchbarSaleState();
}

class _SearchbarSaleState extends State<SearchbarSale> {
  final TextEditingController _controller = TextEditingController();

void _filterSales(String query, {DateTime? startDate, DateTime? endDate}) {
  final filteredList = originalSalesList.where((sale) {
    final matchesQuery = sale.accountName.toLowerCase().contains(query.toLowerCase());
    final timestamp = int.tryParse(sale.id) ?? 0;
    final saleDate = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    final matchesDate = (startDate == null || saleDate.isAfter(startDate.subtract(const Duration(days: 1)))) &&
                        (endDate == null || saleDate.isBefore(endDate.add(const Duration(days: 1))));

    return matchesQuery && matchesDate;
  }).toList();
  salesListNotifier.value = filteredList;
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.07,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _controller,
              onChanged: (query) {
  _filterSales(query);
},

              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onFilterPressed,
            icon: Icon(
              widget.isFilterActive ? Icons.close : Icons.filter_alt,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF68C5CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.onSearchPressed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:const Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
