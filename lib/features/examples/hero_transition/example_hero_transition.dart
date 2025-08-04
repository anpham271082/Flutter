import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_app_flutter/features/examples/hero_transition/example_detail_page.dart';

class ExampleHeroTransition extends StatefulWidget {
  const ExampleHeroTransition({super.key});

  @override
  State<ExampleHeroTransition> createState() => _ExampleHeroTransitionState();
}

class _ExampleHeroTransitionState extends State<ExampleHeroTransition>
    with AutomaticKeepAliveClientMixin {

  final List<String> imageUrls = const [
    'https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d',
    'https://images.unsplash.com/photo-1519681393784-d120267933ba',
    'https://images.unsplash.com/photo-1584395630827-860eee694d7b',
    'https://images.unsplash.com/photo-1604537529428-15bcbeecfe4d',
    'https://images.unsplash.com/photo-1519681393784-d120267933ba',
    'https://images.unsplash.com/photo-1584395630827-860eee694d7b',
  ];

  // Tạo list trạng thái cho từng ảnh: null (chưa tải), true (loaded), false (error)
  late List<bool?> loadStatusList;

  @override
  void initState() {
    super.initState();
    loadStatusList = List<bool?>.filled(imageUrls.length, null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Hero Transition')),
      body: GridView.builder(
        key: const PageStorageKey('heroGrid'),
        padding: const EdgeInsets.all(16),
        itemCount: imageUrls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final url = imageUrls[index];
          final heroTag = '$url-$index';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => ExampleDetailPage(
                    imageUrl: url,
                    heroTag: heroTag,
                  ),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Hero(
              tag: heroTag,
              flightShuttleBuilder: _flightShuttleBuilder,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 400),
                        fadeOutDuration: Duration.zero,
                        placeholderFadeInDuration: const Duration(milliseconds: 400),

                        // Nếu trạng thái chưa load hoặc đang load (null), hiển thị spinner
                        placeholder: (context, url) {
                          if (loadStatusList[index] == null) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            return const SizedBox.shrink();
                          }
                        },

                        errorWidget: (context, url, error) {
                          if (loadStatusList[index] != false) {
                            // Cập nhật trạng thái lỗi
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                loadStatusList[index] = false;
                              });
                            });
                          }
                          return Container(
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.white,
                            ),
                          );
                        },

                        imageBuilder: (context, imageProvider) {
                          if (loadStatusList[index] != true) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                loadStatusList[index] = true;
                              });
                            });
                          }
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.15)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: toHeroContext.widget,
    );
  }

  @override
  bool get wantKeepAlive => true;
}