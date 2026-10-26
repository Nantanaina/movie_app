import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers.dart';
import 'package:flutter_application_1/utils/utils.dart';

// 1
enum MovieType { trending, popular, topRated, nowPlaying }

class MovieWidget extends ConsumerStatefulWidget {
  // 2
  final int movieId;
  final String movieUrl;
  final OnMovieTap onMovieTap;
  final MovieType movieType;
  const MovieWidget({
    required this.movieId,
    required this.movieUrl,
    required this.onMovieTap,
    required this.movieType,
    super.key,
  });

  @override
  ConsumerState<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends ConsumerState<MovieWidget>
    with SingleTickerProviderStateMixin {
  bool animateImage = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late String uniqueHeroTag;

  @override
  void initState() {
    super.initState();
    // 3
    uniqueHeroTag = widget.movieUrl + widget.movieType.name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ref.read(heroTagProvider.notifier).state = uniqueHeroTag;
          animateImage = true;
          _controller.reset();
          _controller.forward();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 100,
          height: 142,
          child: Hero(
            tag: uniqueHeroTag,
            child:
                CachedNetworkImage(
                      imageUrl: widget.movieUrl,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitHeight,
                      height: 100,
                      width: 142,
                    )
                    .animate(
                      // 1
                      autoPlay: false,
                      // 2
                      controller: _controller,
                      // 3
                      onComplete: (controller) {
                        // 4
                        if (animateImage) {
                          animateImage = false;
                          widget.onMovieTap(widget.movieId);
                        }
                      },
                    )
                    // 5
                    .scaleXY(begin: 1.0, end: 1.1, duration: 600.ms)
                    // 6
                    .then(delay: 600.ms)
                    // 7
                    .scaleXY(begin: 1.1, end: 1.0, duration: 600.ms),
          ),
        ),
      ),
    );
  }
}
