import 'package:event_bus/event_bus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_data/movie_data.dart';
import 'package:movie_plugin/movie_plugin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/router/app_routes.dart';
import 'package:flutter_application_1/ui/menus.dart';
import 'package:flutter_application_1/ui/movie_viewmodel.dart';
import 'package:flutter_application_1/utils/prefs.dart';
import 'package:flutter_application_1/utils/utils.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) => AppRouter();

final heroTagProvider = StateProvider<String>((ref) {
  return '';
});

@Riverpod(keepAlive: true)
Future<MovieAPIService> movieAPIService(MovieAPIServiceRef ref) async {
  String apiKey;
  if (!isWeb()) {
    apiKey = dotenv.env['TMDB_KEY']!;
  } else {
    apiKey = await webLoad();
  }
  final service = MovieAPIService(apiKey);
  await service.init();
  return service;
}

Future<String> webLoad() async {
  String apiKey = '';
  try {
    final dotEnvString = await rootBundle.loadString('dotenv');
    if (dotEnvString.contains('TMDB_KEY')) {
      final parts = dotEnvString.split('=');
      if (parts.length == 2) {
        apiKey = parts[1];
        if (apiKey.contains("'")) {
          apiKey = apiKey.replaceAll("'", "");
        }
      }
    } else {
      apiKey = dotEnvString;
    }
  } catch (e) {
    print(e);
  }
  return apiKey;
}

@Riverpod(keepAlive: true)
Future<MovieSource> networkMovieSource(NetworkMovieSourceRef ref) async {
  final service = await ref.read(movieAPIServiceProvider.future);
  return NetworkMovieSource(service);
}

@Riverpod(keepAlive: true)
Future<MovieSource> movieRepository(MovieRepositoryRef ref) async {
  final databaseFuture = ref.watch(databaseProvider.future);
  final serviceFuture = ref.watch(networkMovieSourceProvider.future);
  return MovieRepository(await serviceFuture, await databaseFuture);
}

@Riverpod(keepAlive: true)
Future<MovieViewModel> movieViewModel(MovieViewModelRef ref) async {
  final repositoryFuture = ref.watch(movieRepositoryProvider.future);
  final model = MovieViewModel(await repositoryFuture);
  await model.setup();
  return model;
}

@Riverpod(keepAlive: true)
Prefs prefs(PrefsRef ref) {
  return Prefs(ref.read(moviePluginProvider));
}

@Riverpod(keepAlive: true)
MoviePlugin moviePlugin(MoviePluginRef ref) {
  return MoviePlugin();
}

@Riverpod(keepAlive: true)
Future<IDatabase> driftDatabase(DriftDatabaseRef ref) {
  return Future.value(DriftDatabase());
}

@Riverpod(keepAlive: true)
Future<IDatabase> database(DatabaseRef ref) {
  // Change this to what we want to use
  final firebaseFuture = ref.watch(firebaseProvider.future);
  return firebaseFuture;
}

@Riverpod(keepAlive: true)
Future<IDatabase> firebase(FirebaseRef ref) async {
  return FirebaseDatabase(DefaultFirebaseOptions.currentPlatform);
}

final searchTextProvider = StateProvider<String>((ref) {
  return '';
});

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

@Riverpod(keepAlive: true)
MenuManager menuManager(MenuManagerRef ref) => MenuManager(ref);

@Riverpod(keepAlive: true)
EventBus eventBus(EventBusRef ref) => EventBus();