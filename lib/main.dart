import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzzflutter/blocs/article_list/business_bloc.dart';
import 'package:newzzflutter/blocs/article_list/general_bloc.dart';
import 'package:newzzflutter/blocs/article_list/tech_bloc.dart';
import 'package:newzzflutter/blocs/home/home_bloc.dart';
import 'package:newzzflutter/domain/repositories/article_repo.dart';
import 'package:newzzflutter/ui/home_page.dart';

void main() {
  if (kIsWeb) {
    runApp(AppWidget());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(AppWidget());
    });
  }
}

class AppWidget extends StatelessWidget {
  final ArticleRepo _articleRepo = ArticleRepoImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newzz',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MultiBlocProvider(providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<GeneralBloc>(
          create: (_) => GeneralBloc(
            articleRepo: _articleRepo,
          ),
        ),
        BlocProvider<BusinessBloc>(
          create: (_) => BusinessBloc(
            articleRepo: _articleRepo,
          ),
        ),
        BlocProvider<TechnologyBloc>(
          create: (_) => TechnologyBloc(
            articleRepo: _articleRepo,
          ),
        )
      ], child: HomePage()),
    );
  }
}
