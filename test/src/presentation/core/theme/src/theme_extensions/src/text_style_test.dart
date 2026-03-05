import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/theme/src/theme_extensions/src/text_style.dart';

void main() {
  group('TextStyleExtension', () {
    const extension = TextStyleExtension();

    test('Styles are correctly defined', () {
      expect(extension.headingLarge.fontSize, 24);
      expect(extension.headingMedium.fontSize, 20);
      expect(extension.headingSmall.fontSize, 18);
      expect(extension.bodyLarge.fontSize, 16);
      expect(extension.bodyMedium.fontSize, 14);
      expect(extension.labelMedium.fontSize, 14);
    });

    test('copyWith returns a TextStyleExtension', () {
      final copied = extension.copyWith();
      expect(copied, isA<TextStyleExtension>());
    });

    test('lerp returns a TextStyleExtension', () {
      final lerped = extension.lerp(const TextStyleExtension(), 0.5);
      expect(lerped, isA<TextStyleExtension>());
    });
  });
}
