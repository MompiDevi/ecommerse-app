// Home screen displaying product list, navigation drawer, and cart icon.
// Handles infinite scroll, product loading, and navigation to details and login.
// Uses Bloc for state management and supports lazy loading of products.
import 'package:ecommerse_app/core/app_strings.dart';
import 'package:ecommerse_app/core/theme/app_colors.dart';
import 'package:ecommerse_app/features/presentation/screens/details_screen.dart';
import 'package:ecommerse_app/features/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerse_app/features/presentation/widgets/cart_icon_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/cards/product_card.dart';
import '../widgets/cards/animated_card.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  // Handles infinite scroll to load more products when near the bottom
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !_isLoadingMore) {
      final productBloc = context.read<ProductBloc>();
      if (productBloc.state is ProductLoaded) {
        setState(() => _isLoadingMore = true);
        productBloc.add(LoadMoreProductsEvent());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navigation drawer with logo and sign out
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.amber100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/png/logo_nobg.png',
                    height: 120,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(AppStrings.signOut),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.amber100,
      appBar: AppBar(
        backgroundColor: AppColors.amber100,
        title: Text(AppStrings.eShop),
        actions: [
          CartIconCount(),
        ],
      ),
      // Main body: product grid with Bloc state handling
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            // Show loading spinner while products are loading
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            // Product grid with infinite scroll and animated cards
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  setState(() => _isLoadingMore = false);
                }
                return false;
              },
              child: GridView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.products.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.products.length) {
                    // Product card with animation for first 6 items
                    final card = ProductCard(
                      product: state.products[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(product: state.products[index]),
                          ),
                        );
                      },
                    );
                    if (index < 6) {
                      return AnimatedCard(
                        index: index,
                        child: card,
                      );
                    } else {
                      return card;
                    }
                  } else {
                    // Show loading indicator at the end for lazy loading
                    return Center(child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ));
                  }
                },
            ));
          } else if (state is ProductError) {
            // Show error message if product loading fails
            return Center(child: Text('Error: {state.message}'));
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
