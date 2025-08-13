import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:my_app_flutter/features/examples/example_candidate_model.dart';
import 'package:my_app_flutter/features/examples/example_card.dart';


class ExampleFlutterCardSwiper extends StatefulWidget {
  const ExampleFlutterCardSwiper({super.key});

  @override
  State<ExampleFlutterCardSwiper> createState() => _ExampleFlutterCardSwiperState();
}

class _ExampleFlutterCardSwiperState extends State<ExampleFlutterCardSwiper> {
  final CardSwiperController controller = CardSwiperController();
  final cards = candidates.map(ExampleCard.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter card swiper')),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                padding: const EdgeInsets.all(24.0),

                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) {
                  final int maxVisibleCards = 3;
                  final int topIndex = cards.length - 1;
                  int positionFromTop = topIndex - index;

                  if (positionFromTop < 0 || positionFromTop >= maxVisibleCards) {
                    positionFromTop = maxVisibleCards - 1;
                  }

                  double scale = 1.0 - positionFromTop * 0.1;
                  double offsetY = positionFromTop * 40.0;
                  double offsetX = positionFromTop * 10.0;
                  double rotationAngle = positionFromTop * 5 * 3.14159 / 180;

                  return Transform.translate(
                    offset: Offset(offsetX, offsetY),
                    child: Transform.rotate(
                      angle: rotationAngle,
                      child: Transform.scale(
                        scale: scale,
                        child: cards[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undone from the ${direction.name}',
    );
    return true;
  }
}