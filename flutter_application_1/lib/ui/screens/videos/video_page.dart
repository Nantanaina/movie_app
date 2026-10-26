import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_player/pod_player.dart';
import 'package:flutter_application_1/ui/theme/theme.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movie_data/movie_data.dart';

@RoutePage(name: 'VideoPageRoute')
class VideoPage extends ConsumerStatefulWidget {
    final MovieVideo movieVideo;
  const VideoPage(this.movieVideo, {super.key});

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late final PodPlayerController podPlayerController;

  @override
  void initState() {
    super.initState();
    // 1
    final playVideoFrom = PlayVideoFrom.youtube(
            youtubeUrlFromId(widget.movieVideo.key),
    );
    // 2
    podPlayerController = PodPlayerController(
        playVideoFrom: playVideoFrom,
        podPlayerConfig: const PodPlayerConfig(autoPlay: false))
      ..initialise();
  }

  @override
  void dispose() {
    // 3
    podPlayerController.dispose();
    super.dispose();
  }

  Widget getVideoPlayer(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: screenBackground,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {},
        ),
        centerTitle: false,
        title: Text('Back', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: screenBackground,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PodVideoPlayer(
                controller: podPlayerController,
                matchVideoAspectRatioToFrame: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return getVideoPlayer(context);
  }
}