import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mydemo/di.dart';
import 'package:mydemo/home/home.dart';
import 'package:mydemo/login/presentation/bloc/auth_bloc/auth_bloc.dart';

import 'bloc/products_bloc/products_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                const OnLogout(),
              ),
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: BlocBuilder<ProductsBloc, ProductsState>(
            bloc: sl<ProductsBloc>()..add(const OnGettingProducts()),
            builder: (context, state) {
              if (state is GetProductsInProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetProductsFailure) {
                return Center(child: Text(state.errorMsg));
              } else if (state is GetProductsSuccess) {
                return _buildProductGrid(state.products);
              }

              return const SizedBox();
            },
          ),
        ));
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(product.images.first, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(product.title, style: const TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }
}
