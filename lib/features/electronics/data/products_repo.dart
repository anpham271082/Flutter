import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_app_flutter/features/electronics/model/products_model.dart';

class ProductsRepo {
  static const electronicsUrl =
      'https://fakestoreapi.com/products/category/electronics';

  Future<List<ProductsModel>> getElectronics() async {
    Response response = await http.get(Uri.parse(electronicsUrl));
    return productsModelFromJson(response.body);
  }
}