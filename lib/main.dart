import 'package:flutter/material.dart';
import 'package:flutter_home_work11/presentation/screens/post_list_screen.dart';
import 'package:flutter_home_work11/domain/store/post_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final postStore = PostStore();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter HW11',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => PostsScreen(),
        // '/settings': (context) =>
        //     CommentsScreen(),

      },
    );
  }
}

