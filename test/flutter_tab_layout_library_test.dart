import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tab_layout_library/flutter_tab_layout_library.dart';

void main() {
  group('ModernTabController Tests', () {
    test('initial values are correct', () {
      final controller = ModernTabController(length: 3, initialIndex: 1);
      expect(controller.length, 3);
      expect(controller.selectedIndex, 1);
      expect(controller.initialIndex, 1);
    });

    test('select tab updates index', () {
      final controller = ModernTabController(length: 4);
      expect(controller.selectedIndex, 0);

      controller.select(2);
      expect(controller.selectedIndex, 2);

      // Select out of bounds should be ignored
      controller.select(5);
      expect(controller.selectedIndex, 2);

      controller.select(-1);
      expect(controller.selectedIndex, 2);
    });

    test('next and previous update index within bounds', () {
      final controller = ModernTabController(length: 3);
      expect(controller.selectedIndex, 0);

      controller.next();
      expect(controller.selectedIndex, 1);

      controller.next();
      expect(controller.selectedIndex, 2);

      // Clamped next
      controller.next();
      expect(controller.selectedIndex, 2);

      controller.previous();
      expect(controller.selectedIndex, 1);

      controller.previous();
      expect(controller.selectedIndex, 0);

      // Clamped previous
      controller.previous();
      expect(controller.selectedIndex, 0);
    });

    test('reset animates to initialIndex', () {
      final controller = ModernTabController(length: 3, initialIndex: 1);
      expect(controller.selectedIndex, 1);

      controller.select(2);
      expect(controller.selectedIndex, 2);

      controller.reset();
      expect(controller.selectedIndex, 1);
    });
  });
}
