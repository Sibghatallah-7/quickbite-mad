import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String iconEmoji;
  final Color bgColor;
  final Color cardBgColor;
  final String buttonText;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.iconEmoji,
    required this.bgColor,
    required this.cardBgColor,
    this.buttonText = 'Next',
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _pages = const [
    OnboardingItem(
      title: 'Discover Food',
      subtitle: 'Explore and order from a variety of restaurants with ease.',
      iconEmoji: '👩‍🍳',
      bgColor: Color(0xFFFF6F00),
      cardBgColor: Colors.white,
      buttonText: 'Next',
    ),
    OnboardingItem(
      title: 'Fast Delivery',
      subtitle: 'Looking for Fast Food? Find your closest store and order online. Easy, fast and comfortable',
      iconEmoji: '🛵',
      bgColor: Color(0xFFFDECDA),
      cardBgColor: Colors.white,
      buttonText: 'Next',
    ),
    OnboardingItem(
      title: 'Pick Your Meal At Your Door Steps',
      subtitle: 'We make food ordering fast, simple and free—no matter if you order online or cash',
      iconEmoji: '🍱',
      bgColor: Color(0xFFF7F3E3),
      cardBgColor: Colors.white,
      buttonText: 'Get Started',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _pages[_currentPage];

    return Scaffold(
      backgroundColor: currentItem.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: _currentPage == 0 ? Colors.white70 : Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Onboarding PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration Container Card
                        Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                            color: page.cardBgColor,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  page.iconEmoji,
                                  style: const TextStyle(fontSize: 100),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF6F00).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'QuickBite Express',
                                    style: TextStyle(
                                      color: Color(0xFFFF6F00),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Title
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: index == 0 ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: index == 0 ? Colors.white.withValues(alpha: 0.8) : Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Section: Dots + Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  // Page Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) {
                      final isSelected = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: isSelected ? 24 : 8,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (_currentPage == 0 ? Colors.white : const Color(0xFFFF6F00))
                              : (_currentPage == 0 ? Colors.white38 : Colors.grey[400]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 28),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 0 ? Colors.white : const Color(0xFFFF6F00),
                        foregroundColor: _currentPage == 0 ? const Color(0xFFFF6F00) : Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        currentItem.buttonText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
