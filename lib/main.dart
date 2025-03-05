import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/home/data/datasources/product_remote_data_source.dart';
import 'features/home/data/repositories/product_repository_impl.dart';
import 'features/home/domain/usecases/get_products.dart';
import 'features/home/domain/usecases/filter_products.dart';
import 'features/home/presentation/bloc/product/product_bloc.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            getProducts: GetProducts(
              ProductRepositoryImpl(
                remoteDataSource: ProductRemoteDataSourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
            filterProducts: FilterProducts(
              ProductRepositoryImpl(
                remoteDataSource: ProductRemoteDataSourceImpl(
                  client: http.Client(),
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'E-Commerce Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.white,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
