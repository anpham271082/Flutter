import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExampleLottie extends StatelessWidget {
  const ExampleLottie({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie'),
      ),
      body: PageView(
        controller: controller,
        children: const [
          LottiePage(
            lottieUrl: 'https://assets9.lottiefiles.com/packages/lf20_zrqthn6o.json',
            title: 'Welcome',
            description: 'Discover amazing animations with Lottie for Flutter.',
          ),
          LottiePage(
            lottieUrl: 'https://assets3.lottiefiles.com/packages/lf20_jcikwtux.json',
            title: 'Smooth Animations',
            description: 'Make your UI modern, smooth and beautiful.',
          ),
          LottiePage(
            lottieUrl: 'https://assets4.lottiefiles.com/packages/lf20_tfb3estd.json',
            title: 'Let’s Get Started!',
            description: 'Now you’re ready to build amazing Flutter apps.',
          ),
        ],
      ),
    );
  }
}

class LottiePage extends StatelessWidget {
  final String lottieUrl;
  final String title;
  final String description;

  const LottiePage({
    super.key,
    required this.lottieUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      child: Column(
        children: [
          Expanded(
            child: Lottie.network(
              lottieUrl,
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}