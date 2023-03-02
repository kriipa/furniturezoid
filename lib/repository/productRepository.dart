import 'package:furniturezoid/api/productAPI.dart';
import 'package:furniturezoid/response/productResponse.dart';

class ProductRepository {
  Future<ProductResponse?> getproducts(String? search) async {
    return ProductAPI().getproduct(search);
  }
}
