import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/presentation/core/theme/src/theme_extensions/src/dimensions.dart';

void main() {
  group('Dimensions', () {
    const dimensions = Dimensions();

    test('Spacing values are correctly defined', () {
      expect(dimensions.spacing.s1, 1);
      expect(dimensions.spacing.s1_25, 1.25);
      expect(dimensions.spacing.s2, 2);
      expect(dimensions.spacing.s4, 4);
      expect(dimensions.spacing.s6, 6);
      expect(dimensions.spacing.s8, 8);
      expect(dimensions.spacing.s12, 12);
      expect(dimensions.spacing.s16, 16);
      expect(dimensions.spacing.s24, 24);
      expect(dimensions.spacing.s30, 30);
      expect(dimensions.spacing.s32, 32);
      expect(dimensions.spacing.s44, 44);
      expect(dimensions.spacing.s48, 48);
      expect(dimensions.spacing.s66, 66);
      expect(dimensions.spacing.s80, 80);
      expect(dimensions.spacing.s100, 100);
      expect(dimensions.spacing.s200, 200);
      expect(dimensions.spacing.s210, 210);
    });

    test('Padding values are correctly defined', () {
      expect(dimensions.padding.p4, 4);
      expect(dimensions.padding.p16, 16);
      expect(dimensions.padding.p20, 20);
      expect(dimensions.padding.p24, 24);
    });

    test('Margin and Radius values are correctly defined', () {
      expect(dimensions.margin.m6, 6);
      expect(dimensions.radius.r4, 4);
      expect(dimensions.radius.r6, 6);
    });

    test('copyWith returns a new Dimensions instance', () {
      final copied = dimensions.copyWith();
      expect(copied, isA<Dimensions>());
    });

    test('lerp between two Dimensions returns this or other based on t', () {
      const other = Dimensions();

      // t < 0.5 returns this
      expect(dimensions.lerp(other, 0.4), dimensions);

      // t >= 0.5 returns other
      expect(dimensions.lerp(other, 0.5), other);
    });

    test('lerp returns this if other is null or different type', () {
      expect(dimensions.lerp(null, 0.5), dimensions);
    });
  });
}
