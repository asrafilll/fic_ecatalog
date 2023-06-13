import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/edit_product/edit_product_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/products_bloc.dart';
import 'package:flutter_ecatalog/data/models/request/edit_product_request_model.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key, required this.id});

  final int id;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    context.read<ProductsBloc>().add(GetSingleProductEvent(id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is SingleProductLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(state.data.images![0]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.data.title} - \$${state.data.price}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(state.data.category!.name ?? ''),
                      const SizedBox(height: 8),
                      Text(state.data.description ?? '')
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Edit Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(labelText: 'Price'),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    const SizedBox(
                      width: 8,
                    ),
                    BlocConsumer<EditProductBloc, EditProductState>(
                      listener: (context, state) {
                        if (state is EditProductSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Edit Product Success')),
                          );
                          titleController!.clear();
                          priceController!.clear();
                          Navigator.pop(context);
                          context
                              .read<ProductsBloc>()
                              .add(GetSingleProductEvent(id: state.data.id!));
                        }
                        if (state is EditProductFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Edit Product ${state.errorMessage}'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is EditProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                            onPressed: () {
                              final model = EditProductRequestModel(
                                title: titleController!.text,
                                price: int.parse(priceController!.text),
                              );

                              context.read<EditProductBloc>().add(
                                    DoEditProductEvent(
                                      model: model,
                                      id: widget.id,
                                    ),
                                  );
                            },
                            child: const Text('Edit'));
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
