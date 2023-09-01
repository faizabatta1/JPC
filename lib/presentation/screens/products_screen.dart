import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/screens/cart_screen.dart';
import '../../data/models/product_category.dart';
import '../blocs/products_bloc/products_bloc.dart';
import '../widgets/drawer_screen.dart';
import '../widgets/products_area.dart';
import '../widgets/products_filter_bottom_sheet.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _isSearchExpanded ? _buildSearchField() : Text(''),
        centerTitle: true,
        actions: [
          IconButton(
            icon: _isSearchExpanded ? Icon(Icons.close,color: Colors.black,) : Icon(Icons.search,color: Colors.black,),
            onPressed: () {
              setState(() {
                _isSearchExpanded = !_isSearchExpanded;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ProductFilteringBottomSheet(),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CartScreen())
          );
        },
        backgroundColor: ThemeHelper.primaryColor,
        child: Icon(Icons.shopping_cart,size: 30,),
      ),
      endDrawer: DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              CategoryList(),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<ProductsBloc, ProductState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ProductsStatus.loading:
                      return Container(
                        alignment: Alignment.center,
                        height: 352,
                        child: CircularProgressIndicator(),
                      );
                    case ProductsStatus.success:
                      return ProductsArea(state: state);
                    case ProductsStatus.emptySearch:
                      return Container(
                        alignment: Alignment.center,
                        height: 352,
                        child: Text(
                          'No products found',
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    case ProductsStatus.empty:
                      return Container(
                        alignment: Alignment.center,
                        height: 352,
                        child: Text(
                          'No products available',
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    case ProductsStatus.initial:
                      return Container(
                        alignment: Alignment.center,
                        height: 352,
                        child: Text(
                          'Select a category',
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    case ProductsStatus.error:
                      return Center(
                        child: Text(
                          state.error,
                          style: const TextStyle(fontSize: 30),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<ProductsBloc>().add(SearchProductsEvent(query: _searchController.text));
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              context.read<ProductsBloc>().add(SearchProductsEvent(query: _searchController.text));
            },
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductsCategories(categories: []);
  }
}

class ProductsCategories extends StatelessWidget {
  const ProductsCategories({
    super.key,
    required this.categories,
  });

  final categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map(
              (category) => GestureDetector(
            onTap: () {
              context.read<ProductsBloc>().add(LoadProductsEvent(categoryId: category.id!));
            },
            child: Container(
              width: 120,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              margin: EdgeInsets.all(8.0),
              child: Text(
                category.name,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
