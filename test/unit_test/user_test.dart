import 'package:furniturezoid/models/userModel.dart';
import 'package:furniturezoid/repository/productRepository.dart';
import 'package:furniturezoid/repository/reviewReposiory.dart';
import 'package:furniturezoid/repository/userRepository.dart';
import 'package:furniturezoid/response/productResponse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserRepository? userRepository;
  group("test user register and login", () {
    setUp(() {
      userRepository = UserRepository();
    });
    test("user login test", () async {
      bool expectedResult = true;
      String email = "kripa@gmail.com";
      String password = "12345678";
      User user = User(email: email, password: password);
      bool actual = await UserRepository().loginUser(user);
      expect(actual, expectedResult);
    });

    test("get all product", () async {
      bool expectedResult = true;

      ProductResponse? actial = await ProductRepository().getproducts("havit");
      expect(actial!.success, expectedResult);
    });

    test("user change password", () async {
      bool expectedResult = true;

      String oldPassword = "12345678";

      String newPassword = "qwertyui";

      String passwordConfirm = "qwertyui";

      bool actial = await UserRepository()
          .changePassword(oldPassword, newPassword, passwordConfirm);

      expect(actial, expectedResult);
    });

    test("user register test", () async {
      bool expectedResult = true;
      String name = "sagar";
      String email = "sagar@gmail.com";
      String password = "sagar12345";
      User user = User(name: name, email: email, password: password);
      bool actual = await UserRepository().registerUser(user);
      expect(actual, expectedResult);
    });

    test("user product test", () async {
      bool expectedResult = true;

      String productId = "62ce5d2c14475ac6b01f982d";

      String comment = "kripa@gmail.com";

      int rating = 2;

      bool actial =
          await ReviewRepository().addReview(productId, rating, comment);

      expect(actial, expectedResult);
    });
  });
}
