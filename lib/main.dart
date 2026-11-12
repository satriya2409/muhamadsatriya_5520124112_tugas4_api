
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Makanan',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const FoodPage(),
    );
  }
}

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final ScrollController _scrollController = ScrollController();

  bool _showBackToTopButton = false;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _foods = [
    {
      'name': 'Nasi Goreng',
      'description': 'Nasi goreng spesial dengan telur dan ayam.',
      'price': 'Rp 18.000',
      'image':
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500',
    },
    {
      'name': 'Mie Goreng',
      'description': 'Mie goreng dengan sayuran dan bumbu spesial.',
      'price': 'Rp 15.000',
      'image':
          'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=500',
    },
    {
      'name': 'Sate Ayam',
      'description': 'Sate ayam dengan bumbu kacang khas Indonesia.',
      'price': 'Rp 22.000',
      'image':
          'https://images.unsplash.com/photo-1529563021893-cc83c992d75d?w=500',
    },
    {
      'name': 'Rendang',
      'description': 'Daging sapi empuk dengan bumbu rempah.',
      'price': 'Rp 25.000',
      'image':
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=500',
    },
    {
      'name': 'Bakso',
      'description': 'Bakso sapi dengan kuah hangat dan mie.',
      'price': 'Rp 15.000',
      'image':
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
    },
    {
      'name': 'Ayam Geprek',
      'description': 'Ayam crispy dengan sambal pedas.',
      'price': 'Rp 17.000',
      'image':
          'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=500',
    },
    {
      'name': 'Soto Ayam',
      'description': 'Soto ayam dengan kuah kuning dan nasi.',
      'price': 'Rp 16.000',
      'image':
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=500',
    },
    {
      'name': 'Martabak',
      'description': 'Martabak manis dengan cokelat dan keju.',
      'price': 'Rp 20.000',
      'image':
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500',
    },
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= 300) {
        if (!_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = true;
          });
        }
      } else {
        if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      }
    });
  }

  // Fungsi pull-to-refresh
  Future<void> _refreshFoods() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Daftar makanan berhasil dimuat ulang!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Fungsi kembali ke atas
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Makanan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: _refreshFoods,
        color: Colors.deepOrange,
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: _foods.length,
          itemBuilder: (context, index) {
            final food = _foods[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    food['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.restaurant,
                          size: 60,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          food['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          food['price'],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // Tombol kembali ke atas
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.deepOrange,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
