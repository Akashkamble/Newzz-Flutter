import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzzflutter/blocs/article_list/article_list_bloc.dart';
import 'package:newzzflutter/blocs/home/home_bloc.dart';
import 'package:newzzflutter/domain/repositories/article_repo.dart';
import 'package:newzzflutter/ui/home_page.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newzz',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (_) => HomeBloc(),
            ),
            BlocProvider<ArticleBloc>(
              create: (_) => ArticleBloc(
                articleRepo: ArticleRepoImpl(),
              ),
            )
          ],
          child: HomePage()),
    );
  }
}
