import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> pets = const [
    {
      'name': 'Bella',
      'image': 'https://images.unsplash.com/photo-1574158622682-e40e69881006',
    },
    {
      'name': 'Charlie',
      'image': 'https://images.unsplash.com/photo-1574158622682-e40e69881006',
    },
    {
      'name': 'Max',
      'image': 'https://images.unsplash.com/photo-1574158622682-e40e69881006',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'PawPal - Pet Adoption',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.appBarTheme.foregroundColor ?? Colors.white,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color.fromARGB(255, 39, 39, 39),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Dogs'),
              Tab(text: 'Cats'),
              Tab(text: 'Birds'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: theme.primaryColor),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.pets),
                title: const Text('Dogs'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.pets),
                title: const Text('Cats'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.pets),
                title: const Text('Birds'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(4, (index) {
            if (index == 0) {
              // Visible background for padding
              return Container(
                color:
                    theme.brightness == Brightness.dark
                        ? const Color(0xFF2C2C2C)
                        : const Color(0xFFFBE9E7), // light peach background
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: const [
                    CategoryCard(title: 'Dogs', icon: FontAwesomeIcons.dog),
                    CategoryCard(title: 'Cats', icon: FontAwesomeIcons.cat),
                    CategoryCard(title: 'Birds', icon: FontAwesomeIcons.dove),
                    CategoryCard(title: 'Others', icon: Icons.pets),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Swipe to find your PawPal!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        children: [
                          // Swiper
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 300,
                            child: CardSwiper(
                              cardsCount: pets.length,
                              cardBuilder: (
                                BuildContext context,
                                int index,
                                int realIndex,
                                int cardCount,
                              ) {
                                final pet = pets[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        pet['image']!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        child: Text(
                                          pet['name']!,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 20,
                                                color: Color.fromARGB(
                                                  255,
                                                  41,
                                                  41,
                                                  41,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Thumbnails
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Other Pets',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: pets.length,
                                    itemBuilder: (context, index) {
                                      final pet = pets[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 12.0,
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                pet['image']!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              pet['name']!,
                                              style: TextStyle(
                                                color:
                                                    theme
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}

// CategoryCard widget with theme support
class CategoryCard extends StatelessWidget {
  final String title;
  final dynamic icon;

  const CategoryCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon is IconData
                  ? Icon(icon, size: 40, color: Colors.deepOrange)
                  : FaIcon(icon, size: 40, color: Colors.deepOrange),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
