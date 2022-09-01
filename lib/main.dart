import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:state_managements_in_life/feature/login/view/login_view.dart';
import 'package:state_managements_in_life/feature/onboard/on_board_view.dart';
import 'package:provider/provider.dart';
import 'package:state_managements_in_life/product/model/state/project_context.dart';
import 'package:state_managements_in_life/product/model/state/user_context.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductContext()),
        ProxyProvider<ProductContext, UserContext?>(
          update: (context, productContext, userContext) {
            return userContext != null
                ? userContext.copyWith(name: productContext.newUserName)
                : UserContext(productContext.newUserName);
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'State Management in life',
        home: const LoginView(),
        theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark, elevation: 0),
            backgroundColor: Colors.grey[300],
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromRGBO(11, 23, 84, 1),
            )),
      ),
    );
  }
}
