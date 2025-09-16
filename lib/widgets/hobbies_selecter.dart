import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HobbiesSelectorCard extends StatefulWidget {
  const HobbiesSelectorCard({super.key});
  @override
  State<HobbiesSelectorCard> createState() => _HobbiesSelectorCardState();
}

class _Hobby {
  final String label;
  final Widget Function(Color color, double size) iconBuilder;
  bool selected;
  _Hobby(this.label, this.iconBuilder, {this.selected = false});
}

class _HobbiesSelectorCardState extends State<HobbiesSelectorCard> {
  final Color _chipText = const Color(0xFF111827);
  final Color _primary = const Color(0xFF0B48EE);

  final List<Color> _iconPalette = const [
    Color(0xFF2861F4), // blue-600
    Color(0xFF067C57), // emerald-600
    Color(0xFFF4661E), // orange-600
    Color(0xFF620AF5), // violet-600
    Color(0xFF0AF160), // green-600
    Color(0xFFEB579B), // pink-600
    Color(0xFF35BDF8), // sky-500
    Color(0xFFF1B04A), // amber-500
    Color(0xFFF05B5B), // red-600
    Color(0xFF9E4BEB), // purple-600
    Color(0xFF029685), // teal-500
    Color(0xFF5593F7), // blue-500
  ];

  final Random _rng = Random();
  final Map<String, Color> _idleIconColors = {};

  late final List<_Hobby> _items = [
    _Hobby('Music', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedVynil02, color: c, size: s)),
    _Hobby('Camping', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedHut, color: c, size: s)),
    _Hobby('Travel', (c, s) => Icon(Icons.airplanemode_active, color: c, size: s), selected: true),
    _Hobby('Fashion', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedTShirt, color: c, size: s)),
    _Hobby('Books', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedBookOpen01, color: c, size: s)),
    _Hobby('Learning', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedMortarboard02, color: c, size: s)),
    _Hobby('Sports', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedBicycle, color: c, size: s), selected: true),
    _Hobby('Stocks', (c, s) => HugeIcon(icon: HugeIcons.strokeRoundedAppleStocks, color: c, size: s)),
  ];

  Color _randomPaletteColor() => _iconPalette[_rng.nextInt(_iconPalette.length)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 820),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(color: Color(0x1F111827), blurRadius: 24, offset: Offset(0, 8)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Your Favorite Hobbies',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, height: 1.2),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _items.map((h) {
                      final idle = _idleIconColors.putIfAbsent(h.label, _randomPaletteColor);
                      return _HobbyChip(
                        label: h.label,
                        iconBuilder: h.iconBuilder,
                        selected: h.selected,
                        primary: _primary,
                        chipBg: _primary.withAlpha(20),
                        chipText: _chipText,
                        idleIconColor: idle,
                        onTap: () {
                          setState(() {
                            h.selected = !h.selected;
                            if (!h.selected) _idleIconColors[h.label] = _randomPaletteColor();
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HobbyChip extends StatelessWidget {
  final String label;
  final Widget Function(Color color, double size) iconBuilder;
  final bool selected;
  final VoidCallback onTap;
  final Color primary;
  final Color chipBg;
  final Color chipText;
  final Color idleIconColor;

  const _HobbyChip({
    required this.label,
    required this.iconBuilder,
    required this.selected,
    required this.onTap,
    required this.primary,
    required this.chipBg,
    required this.chipText,
    required this.idleIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? primary : chipBg;
    final fg = selected ? Colors.white : chipText.withOpacity(0.95);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(28)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: selected ? Colors.white.withOpacity(0.2) : Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.center,
              child: iconBuilder(selected ? Colors.white : idleIconColor, 17),
            ),
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: fg)),
            if (selected)
              const SizedBox(
                width: 28,
                height: 28,
                child: Center(child: Icon(Icons.close, size: 17, color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}