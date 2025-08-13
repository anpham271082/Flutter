import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/examples/swipe_card/swipe_card.dart';

class CardData {
  final String image;
  final String title;
  CardData(this.image, this.title);
}

class ExampleSwipeCard extends StatefulWidget {
  const ExampleSwipeCard({super.key});

  @override
  State<ExampleSwipeCard> createState() =>
      _ExampleSwipeCardState();
}

class _ExampleSwipeCardState extends State<ExampleSwipeCard> {
  late List<CardData> cards;

  @override
  void initState() {
    super.initState();
    cards = [
      CardData('assets/images/CherryBlossom.jpg', 'CherryBlossom'),
      CardData('assets/images/Catalina.jpg', 'Hamburg'),
      CardData('assets/images/LonsdaleQuay.jpg', 'LonsdaleQuay'),
      CardData('assets/images/Elbphilharmonie.jpg', 'Elbphilharmonie'),
      CardData('assets/images/beach.jpg', 'Elbphilharmonie'),
    ];
  }

  void onCardSwiped(SwipeDirection direction) {
    if (cards.isEmpty) return;

    print(
        "Card ${cards.last.title} was swiped ${direction == SwipeDirection.right ? "right" : "left"}");

    setState(() {
      cards.removeLast();
    });

    if (cards.isEmpty) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Card')),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          height: 400,
          child: Stack(
            clipBehavior: Clip.none,
            children: cards.asMap().entries.map((entry) {
              int pos = cards.length - 1 - entry.key; // reversed index
              final scale = 1.0 - pos * 0.05;
              final translateY = pos * 20.0;

              return Positioned(
                top: translateY,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: scale,
                  child: SwipeCard(
                    key: ValueKey(entry.value.title),
                    imageAsset: entry.value.image,
                    title: entry.value.title,
                    onSwiped: onCardSwiped,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}