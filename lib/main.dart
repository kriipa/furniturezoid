import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:furniturezoid/screens/cart/cart_provider.dart';
import 'package:furniturezoid/screens/cart/screen.dart';
import 'package:furniturezoid/screens/navigation_screen.dart';
import 'package:furniturezoid/screens/order_history/order_details.dart';
import 'package:furniturezoid/screens/order_history/order_history.dart';
import 'package:furniturezoid/screens/payment/order_confirm.dart';
import 'package:furniturezoid/screens/payment/shipping_details.dart';
import 'package:furniturezoid/screens/product_details/item_details_page.dart';
import 'package:furniturezoid/screens/profile_page/change_password.dart';
import 'package:furniturezoid/screens/profile_page/edit_profile.dart';
import 'package:furniturezoid/screens/profile_page/googlemap.dart';
import 'package:furniturezoid/screens/profile_page/profile_screen.dart';
import 'package:furniturezoid/screens/review/review_screen.dart';
import 'package:furniturezoid/screens/signin.dart';
import 'package:furniturezoid/screens/signout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:furniturezoid/wearOs/login.dart';
import 'package:provider/provider.dart';

// late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51LLLPoKaRPx08H0846E1eAB75FHnMgR0abUlVKuZsmnPyzO7c1SBVYGTsl2u33MCKRJccnsVJ2ox6bcf2oUbcjJP00HspIipe5';
  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
      channelGroupKey: 'basic_channel_group',
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      defaultColor: const Color.fromARGB(255, 232, 242, 241),
      importance: NotificationImportance.Max,
      ledColor: const Color.fromARGB(255, 157, 120, 9),
      channelShowBadge: true,
      channelDescription: 'Notification for the basic test of the app',
    ),
  ]);
  // objectBox = await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            initialRoute: '/signin',
            theme: ThemeData(
                primaryColor: Colors.brown,
                appBarTheme: AppBarTheme(
                  color: Color.fromARGB(255, 83, 59, 50)), 
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.brown).copyWith(
                      secondary: Color.fromARGB(255, 108, 75, 39))),
            routes: {
              '/': (context) => const WearOsLogin(),
              '/signin': (context) => const SignIn(),
              '/navigation_screen': (context) => NavigationDrawers(),
              '/register': (context) => const SignOut(),
              // '/onboard': (context) =>  GetStarted(),
              '/new': (context) => ItemDetailsPage(),
              '/profile': (context) => const ProfileScreen(),
              '/editprofile': (context) => const EditProfile(),
              // '/cart': (context) => const CartPage(),
              '/carts': (context) => const CartScreen(),
              '/review': (context) => const ReviewScreen(),
              '/shipping': (context) => const ShippngScreen(),
              '/confirm_order': (context) => const ConfirmOrderScreen(),
              '/password': (context) => const ChangePassword(),
              '/order_history': (context) => const OrderHistory(),
              '/order_details': (context) => const OrderDetails(),
              '/map': (context) => const MapScreen(),
            },
            title: 'Flutter Demo',
            // themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
