import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/data/items.dart' as items_data;
import 'package:greengrocer/src/screens/home/components/category_tile.dart';
import 'package:greengrocer/src/screens/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // # App Bar #
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: 'Green',
                style: TextStyle(
                  color: CustomColors.customSwathColor.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'grocer',
                style: TextStyle(
                  color: CustomColors.customContrastColor,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {},
              child: Badge(
                backgroundColor: CustomColors.customContrastColor,
                textColor: Colors.white,
                label: const Text('2'),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwathColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // # Campo de Pesquisa #
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquise aqui...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.customContrastColor,
                  size: 21,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          // # Categorias #
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoryTile(
                onTap: () {
                  setState(() {
                    selectedCategory = items_data.categories[index];
                  });
                },
                category: items_data.categories[index],
                isSelected: items_data.categories[index] == selectedCategory,
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: items_data.categories.length,
            ),
          ),
          // # Grid View #
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 11.5,
              ),
              itemCount: items_data.items.length,
              itemBuilder: (context, index) => ItemTile(
                item: items_data.items[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
