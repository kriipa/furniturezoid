import 'package:furniturezoid/api/reviewAPI.dart';
import 'package:furniturezoid/response/reviewResponse.dart';

class ReviewRepository {
  Future<bool> addReview(String id, int rating, String comment) async {
    return ReviewApi().addReview(id, rating, comment);
  }

  Future<ReviewResponse> getReview(String id) async {
    return ReviewApi().getReviews(id);
  }
}
