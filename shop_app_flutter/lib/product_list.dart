import 'package:flutter/material.dart';
import 'package:shop_app_flutter/global_variables.dart';
import 'package:shop_app_flutter/product_cart.dart';
import 'package:shop_app_flutter/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filter = const ['All', 'Nike', 'Addidas', 'Bata'];
  late String selectedfilters;
  @override
  void initState() {
    super.initState();
    selectedfilters = filter[0];
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '   Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filter.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filters = filter[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedfilters = filters;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedfilters == filters
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1)),
                      label: Text(filters),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
            builder:(context,constraints) {
              if(constraints.maxWidth >650){
                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsPage(product: product);
                            },
                          ),
                        );
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    );
                  },
                );
    }else{
              return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
              onTap: () {
              Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) {
              return ProductDetailsPage(product: product);
              },
              ),
              );
              },
              child: ProductCard(
              title: product['title'] as String,
              price: product['price'] as double,
              image: product['imageUrl'] as String,
              backgroundColor: index.isEven
              ? const Color.fromRGBO(216, 240, 253, 1)
                  : const Color.fromRGBO(245, 247, 249, 1),
              ),
              );
              },
              );
              }

    },
            ),



          ),
        ],
      ),
    );
  }
}
