import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/product_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/skeleton_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductBloc>().add(
            GetProductsEvent(
              offset: context.read<ProductBloc>().state is ProductsLoaded
                  ? (context.read<ProductBloc>().state as ProductsLoaded).products.length
                  : 0,
            ),
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(RefreshProductsEvent());
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // App Bar with Search
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    const Text(
                      'Shop',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomSearchBar(),
                  ),
                ),
              ),

              // Cashback Banner
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E3B6E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A Summer Surprise',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Cashback 20%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Popular Products Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See more'),
                      ),
                    ],
                  ),
                ),
              ),

              // Products Grid
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductInitial) {
                    return const SliverToBoxAdapter(
                      child: SkeletonProductGrid(itemCount: 4),
                    );
                  } else if (state is ProductLoading && state is! ProductsLoaded) {
                    return const SliverToBoxAdapter(
                      child: SkeletonProductGrid(itemCount: 4),
                    );
                  } else if (state is ProductsLoaded) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // Products Grid
                          ProductGrid(
                            products: state.products,
                            scrollController: null, // Using the parent controller
                          ),

                          // Loading indicator at bottom for pagination
                          if (!state.hasReachedMax)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      ),
                    );
                  } else if (state is ProductError) {
                    return SliverFillRemaining(
                      child: ErrorView(
                        message: state.message,
                        onRetry: () {
                          context.read<ProductBloc>().add(GetProductsEvent());
                        },
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
