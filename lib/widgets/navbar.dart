import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

/// Pill-style bottom navigation bar using HugeIcons.
/// Drop this into `bottomNavigationBar:` of a Scaffold,
/// or use anywhere you'd render a nav bar.
///
/// Example:
/// bottomNavigationBar: HugePillBottomNav(
///   currentIndex: _index,
///   onTap: (i) => setState(() => _index = i),
/// ),
class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF12121A); // dark bar background
    const pill = Colors.white;     // active chip bg
    const iconIdle = Color(0xFFEAEAF0);
    const textActive = Color(0xFF0F0F14);

    final items = <_NavItem>[
      _NavItem(
        label: 'Home',
        iconBuilder: (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedHome01, color: c, size: s),
      ),
      _NavItem(
        label: 'Search',
        iconBuilder: (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedSearch01, color: c, size: s),
      ),
      _NavItem(
        label: 'Offers',
        iconBuilder: (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedDiscountTag02, color: c, size: s), // % tag
      ),
      _NavItem(
        label: 'Cart',
        iconBuilder: (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedShoppingCartCheckIn02, color: c, size: s),
      ),
      _NavItem(
        label: 'Profile',
        iconBuilder: (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedUserCircle, color: c, size: s),
      ),
    ];

    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              items.length, (i) {
            final active = i == currentIndex;
            final item = items[i];

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.linearToEaseOut,
                padding: EdgeInsets.symmetric(
                  horizontal: active ? 12 : 0,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: active ? pill : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: active
                        ? Row(
                      key: const ValueKey('active'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        item.iconBuilder(textActive, 20),
                        const SizedBox(width: 8),
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: textActive,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    )
                        : Container(
                      key: const ValueKey('idle'),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: item.iconBuilder(iconIdle, 22),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final Widget Function(Color color, double size) iconBuilder;
  const _NavItem({required this.label, required this.iconBuilder});
}
