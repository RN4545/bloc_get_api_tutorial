import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/bloc/post_bloc.dart';
import 'package:post/ui/screen_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(),
      child: MaterialApp(
        title: "POST THROUGH API",
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
        ),
        home: const ScreenPost(),
      ),
    );
  }
}
