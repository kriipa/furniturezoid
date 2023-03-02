import 'package:furniturezoid/api/orderAPI.dart';
import 'package:furniturezoid/response/orderResponse.dart';

class OrderRepository{
  Future<OrderResponse> getOrderHistory() async{
    return OrderAPI().getOrderHistory();
  }
}
