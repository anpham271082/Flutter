import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProfile extends StatefulWidget {
  const ShimmerProfile({super.key});

  @override
  State<ShimmerProfile> createState() => _ShimmerProfileState();
}

class _ShimmerProfileState extends State<ShimmerProfile>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Tạo animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Delay 3s rồi chuyển isLoading và chạy animation fadeIn
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => isLoading = false);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.white;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading
          ? Shimmer.fromColors(
              key: const ValueKey('shimmer'),
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(radius: 50, backgroundColor: baseColor),
                  const SizedBox(height: 20),
                  Container(height: 16, width: 150, color: baseColor),
                  const SizedBox(height: 10),
                  Container(height: 16, width: 200, color: baseColor),
                  const SizedBox(height: 30),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, __) => Container(
                      height: 50,
                      width: double.infinity,
                      color: baseColor,
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                    ),
                  )
                ],
              ),
            )
          : FadeTransition(
              key: const ValueKey('loaded'),
              opacity: _fadeAnimation,
              child: _buildProfileContent(),
            ),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 50,
            backgroundImage:
                NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'john.doe@example.com',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _buildInfoCard(Icons.person, 'Username', 'johndoe123'),
          const SizedBox(height: 16),
          _buildInfoCard(Icons.phone, 'Phone', '+1 234 567 890'),
          const SizedBox(height: 16),
          _buildInfoCard(Icons.location_on, 'Location', 'New York, USA'),
          const SizedBox(height: 16),
          _buildInfoCard(Icons.settings, 'Settings', 'Account Preferences'),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(blurRadius: 10, color: Colors.black12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}