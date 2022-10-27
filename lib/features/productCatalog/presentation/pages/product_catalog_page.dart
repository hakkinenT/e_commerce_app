import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_item.dart';
import '../bloc/productcatalog_bloc.dart';
import '../../../../themes/app_colors.dart';
import '../../../../injection_container.dart';
import '../widgets/product_item_widget.dart';

class ProductCatalogPage extends StatelessWidget {
  const ProductCatalogPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductcatalogBloc>(),
      child: const ProductCatalogView(),
    );
  }
}

class ProductCatalogView extends StatefulWidget {
  const ProductCatalogView({super.key});

  @override
  State<ProductCatalogView> createState() => _ProductCatalogViewState();
}

class _ProductCatalogViewState extends State<ProductCatalogView> {
  @override
  void initState() {
    BlocProvider.of<ProductcatalogBloc>(context).add(ProductcatalogFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                // TODO: Colocar a rota para o carrinho de compras
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: BlocBuilder<ProductcatalogBloc, ProductcatalogState>(
          builder: (context, state) {
        if (state is ProductcatalogLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ),
          );
        } else if (state is ProductcatalogSuccess) {
          final products = state.productItems;
          return ProductCatalogGridList(
            products: products,
          );
        } else if (state is ProductcatalogError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class ProductCatalogGridList extends StatelessWidget {
  final List<ProductItem> products;
  const ProductCatalogGridList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              mainAxisExtent: 280,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6),
          itemBuilder: (context, index) {
            return ProductItemWidget(
                product: products[index],
                onPressed: () {
                  // TODO: Navegar para a pagina de detalhes do produto
                });
          }),
    );
  }
}
