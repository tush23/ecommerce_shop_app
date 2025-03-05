import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int? limit, int? offset});
  Future<List<ProductModel>> filterProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({int? limit, int? offset}) async {
    String url = '${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}';

    if (limit != null) {
      url += '?limit=$limit';
      if (offset != null) {
        url += '&skip=$offset';
      }
    }

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to load products');
    }
  }

  @override
  Future<List<ProductModel>> filterProducts(String query) async {
    // First get all products, then filter by query
    final products = await getProducts();

    if (query.isEmpty) {
      return products;
    }

    return products.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
