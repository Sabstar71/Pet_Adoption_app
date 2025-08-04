import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> pets = const [
    {
      'name': 'Bella',
      'image': 'https://images.unsplash.com/photo-1574158622682-e40e69881006',
      'breed': 'Golden Retriever',
      'age': '2 years',
      'sex': 'Female',
    },
    {
      'name': 'Charlie',
      'image': 'https://images.unsplash.com/photo-1543466835-00a7907e9de1',
      'breed': 'Labrador',
      'age': '1 year',
      'sex': 'Male',
    },
    {
      'name': 'Max',
      'image': 'https://images.unsplash.com/photo-1587300003388-59208cc962cb',
      'breed': 'Beagle',
      'age': '3 years',
      'sex': 'Male',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ThemeProvider.lightBackground,
        appBar: AppBar(
          backgroundColor: ThemeProvider.primaryAmber,
          foregroundColor: ThemeProvider.lightTextColor,
          elevation: 0,
          title: Text(
            'PawPal - Pet Adoption',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ThemeProvider.lightTextColor,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: ThemeProvider.lightTextColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications_none, color: ThemeProvider.lightTextColor),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: ThemeProvider.lightTextColor,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            labelColor: ThemeProvider.lightTextColor,
            unselectedLabelColor: ThemeProvider.lightTextColor.withOpacity(0.7),
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
                decoration: BoxDecoration(
                  color: ThemeProvider.primaryAmber,
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1548199973-03cce0bbc87b'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      ThemeProvider.primaryAmber.withOpacity(0.7),
                      BlendMode.srcOver,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'PawPal',
                      style: TextStyle(
                        color: ThemeProvider.lightTextColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Find your perfect companion',
                      style: TextStyle(
                        color: ThemeProvider.lightTextColor.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.dog, color: ThemeProvider.primaryAmber),
                title: Text('Dogs', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.cat, color: ThemeProvider.primaryAmber),
                title: Text('Cats', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.dove, color: ThemeProvider.primaryAmber),
                title: Text('Birds', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.favorite_border, color: ThemeProvider.primaryAmber),
                title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.history, color: ThemeProvider.primaryAmber),
                title: Text('Adoption History', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings, color: ThemeProvider.primaryAmber),
                title: Text('Settings', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(4, (index) {
            if (index == 0) {
              // All pets categories view
              return Container(
                color: ThemeProvider.lightBackground,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ThemeProvider.primaryAmber,
                            ThemeProvider.primaryAmber.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeProvider.primaryAmber.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Find Your Perfect Match",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: ThemeProvider.lightTextColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Swipe through our available pets and find your new best friend",
                            style: TextStyle(
                              fontSize: 14,
                              color: ThemeProvider.lightTextColor.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeProvider.cardColor,
                              foregroundColor: ThemeProvider.primaryAmber,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                            child: Text(
                              "Get Started",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    Text(
                      "Browse by Category",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ThemeProvider.lightTextColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // Categories grid
                    Expanded(
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
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: ThemeProvider.lightBackground,
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ThemeProvider.lightTextColor,
                      ),
                    ),
                    Text(
                      'Discover pets available for adoption',
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeProvider.secondaryTextColor,
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
                                  elevation: 8,
                                  shadowColor: ThemeProvider.shadowColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      // Pet image
                                      Image.network(
                                        pet['image']!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: ThemeProvider.primaryAmber,
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) => 
                                          Container(
                                            color: ThemeProvider.disabledColor,
                                            child: Icon(Icons.pets, size: 50, color: ThemeProvider.primaryAmber),
                                          ),
                                      ),
                                      
                                      // Gradient overlay for better text visibility
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        height: 120,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                ThemeProvider.shadowColor.withOpacity(0.8),
                                                ThemeProvider.transparentColor,
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      // Pet info
                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        right: 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pet['name']!,
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: ThemeProvider.lightTextColor,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '${pet['breed']} · ${pet['age']}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: ThemeProvider.lightTextColor.withOpacity(0.9),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  pet['sex'] == 'Male' ? Icons.male : Icons.female,
                                                  color: ThemeProvider.lightTextColor,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  pet['sex']!,
                                                  style: TextStyle(
                                                    color: ThemeProvider.lightTextColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      // Action buttons
                                      Positioned(
                                        top: 16,
                                        right: 16,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ThemeProvider.cardColor.withOpacity(0.9),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.favorite_border, color: ThemeProvider.errorColor),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                          ),
                                        ),
                                      );
                              };
  }),
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
                                    fontSize: 18,
                                    color: ThemeProvider.lightTextColor,
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
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ThemeProvider.cardColor,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ThemeProvider.shadowColor.withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  pet['image']!,
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) => 
                                                    Container(
                                                      width: 70,
                                                      height: 70,
                                                      color: ThemeProvider.disabledColor,
                                                      child: Icon(Icons.pets, size: 30, color: ThemeProvider.primaryAmber),
                                                    ),
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      pet['name']!,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: ThemeProvider.lightTextColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      pet['breed']!,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: ThemeProvider.secondaryTextColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeProvider.primaryAmber.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        color: ThemeProvider.cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: ThemeProvider.primaryAmber.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: icon is IconData
                        ? Icon(icon, size: 40, color: ThemeProvider.primaryAmber)
                        : FaIcon(icon, size: 40, color: ThemeProvider.primaryAmber),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeProvider.lightTextColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeProvider.primaryAmber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
