import 'package:flutter/material.dart';
import 'package:firebaseiti/utils/app_colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> foodList = [];
  bool isLoading = true;

  Future<void> fetchFood() async {
    final url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/categories.php',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List categories = jsonBody['categories'];
      setState(() {
        foodList = categories.map<Map<String, String>>((cat) {
          return {
            'name': cat['strCategory'],
            'thumb': cat['strCategoryThumb'],
            'desc': cat['strCategoryDescription'],
            'like': '0',
          };
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load food');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFood();
  }

  Widget buildIconRow() {
    final icons = [
      {'icon': Icons.fastfood_rounded, 'label': 'Fast Food'},
      {'icon': Icons.cake, 'label': 'Cake'},
      {'icon': Icons.cookie_sharp, 'label': 'Snacks'},
      {'icon': Icons.emoji_food_beverage_rounded, 'label': 'Drinks'},
      {'icon': Icons.local_pizza, 'label': 'Pizza'},
      {'icon': Icons.icecream, 'label': 'Ice Cream'},
      {'icon': Icons.lunch_dining_rounded, 'label': 'Burger'},
      {'icon': Icons.kebab_dining, 'label': 'BBQ'},
    ];

    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Icon(
                  icons[index]['icon'] as IconData,
                  size: 30,
                  color: AppColors.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    icons[index]['label'] as String,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://www.themealdb.com/images/category/beef.png',
                  ),
                  radius: 24,
                ),
                Icon(Icons.menu, color: AppColors.black),
              ],
            ),
            Text(
              'Hello, Pino',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'What do you want to buy?',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
              ),
            ),
            buildIconRow(),
            const SizedBox(height: 16),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        final food = foodList[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    food['thumb']!,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food['name']!,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        food['desc']!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(),
                                            child: const Text('Add to cart'),
                                          ),
                                          const Text('\$100'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                IconButton(
                                  icon: Icon(
                                    food['like'] == '1'
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: food['like'] == '1'
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      food['like'] = (food['like'] == '1')
                                          ? '0'
                                          : '1';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
