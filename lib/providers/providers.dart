import 'package:provider/provider.dart';
import "package:provider/single_child_widget.dart";
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/providers/brand_provider.dart';
import 'package:rental_services/providers/search_provider.dart';
import 'package:rental_services/providers/category_provider.dart';
import 'package:rental_services/providers/business_provider.dart';
import 'package:rental_services/providers/home_screen-provider.dart';
import 'package:rental_services/providers/product_provider.dart';
import 'package:rental_services/providers/vendor_provider.dart';
import 'package:rental_services/providers/rent_provider.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create:(context)=> Login_Provider(),
  ),
  ChangeNotifierProvider(
      create: (context)=>Brand_Provider(),
  ),
  ChangeNotifierProvider(
      create: (context)=>Search_Provider(),
  ),
  ChangeNotifierProvider(
    create: (context)=>Category_Provider(),
  ),
  ChangeNotifierProvider(
    create: (context)=>Business_Provider(),
  ),
  ChangeNotifierProvider(
      create: (context) => Home_Screen_Provider()
  ),
  ChangeNotifierProvider(
      create: (context) => Product_Provider()
  ),
  ChangeNotifierProvider(
      create: (context) => Vendor_Provider()
  ),
  ChangeNotifierProvider(
      create: (context)=> Rent_Provider())
];