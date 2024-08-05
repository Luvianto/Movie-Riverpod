import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:procom_kas/data/models/movie_model.dart';
import 'package:procom_kas/data/states/movie_state.dart';

class MovieScreen extends ConsumerWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie"),
      ),
      body: const Center(
        child: MovieCheckWidget(),
      ),
    );
  }
}

class MovieCheckWidget extends ConsumerStatefulWidget {
  const MovieCheckWidget({super.key});

  @override
  MovieCheckWidgetState createState() => MovieCheckWidgetState();
}

class MovieCheckWidgetState extends ConsumerState<MovieCheckWidget> {
  late final MovieNotifier movieNotifier;
  late final List<MovieModel> movieList;
  @override
  void initState() {
    movieNotifier = ref.read(movieNotifierProvider.notifier);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieNotifier.getMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (movieState.isLoading)
              const CircularProgressIndicator()
            else if (movieState.errorMessage != null)
              Text(movieState.errorMessage!)
            else if (movieState.data == null)
              const Text('No data found')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: movieState.data!.length,
                  itemBuilder: (context, index) {
                    final movie = movieState.data![index];
                    return ListTile(
                      title: Text(movie.title),
                      subtitle: Text('Release Date: ${movie.releaseDate}'),
                    );
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () {
                movieNotifier.getMovie();
              },
              child: const Text('Fetch Movie'),
            ),
          ],
        ),
      ),
    );
  }
}
