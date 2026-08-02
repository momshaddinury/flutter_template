part of '../colors.dart';

// The raw palette: every surface and text colour the app is allowed to
// paint with. Drop shadows draw from their own ink primitive in the
// dimensions layer.
//
// This is the file a project edits at kickoff. Swap these values for the
// project palette and every screen re-skins through the semantic layer;
// no widget changes. The palette that ships here is a deliberately plain
// placeholder.
//
// Nothing outside the semantic layer reads these. Widgets ask for meaning
// (`context.color.text.muted`), never for a swatch.

/// The brand hue.
abstract final class _Brand {
  static const Color s50 = Color(0xFFE7F0FE);
  static const Color s400 = Color(0xFF4A94F4);
  static const Color s500 = Color(0xFF1877F2);
  static const Color s600 = Color(0xFF1465CE);
  static const Color s900 = Color(0xFF102A4C);
}

/// The gray ramp both modes are built from.
abstract final class _Neutral {
  static const Color s0 = Color(0xFFFFFFFF);
  static const Color s100 = Color(0xFFF1F3F5);
  static const Color s200 = Color(0xFFE9ECEF);
  static const Color s300 = Color(0xFFDEE2E6);
  static const Color s500 = Color(0xFF868E96);
  static const Color s700 = Color(0xFF495057);
  static const Color s800 = Color(0xFF343A40);
  static const Color s900 = Color(0xFF212529);
  static const Color s950 = Color(0xFF16181B);
}

/// Success.
abstract final class _Green {
  static const Color s50 = Color(0xFFEBFBEE);
  static const Color s500 = Color(0xFF2F9E44);
  static const Color s900 = Color(0xFF132A1B);
}

/// Warning.
abstract final class _Amber {
  static const Color s50 = Color(0xFFFFF9DB);
  static const Color s500 = Color(0xFFF59F00);
  static const Color s900 = Color(0xFF2E2510);
}

/// Danger.
abstract final class _Red {
  static const Color s50 = Color(0xFFFFF5F5);
  static const Color s500 = Color(0xFFE03131);
  static const Color s900 = Color(0xFF2C1517);
}

/// Information.
abstract final class _Blue {
  static const Color s50 = Color(0xFFE7F5FF);
  static const Color s500 = Color(0xFF1971C2);
  static const Color s900 = Color(0xFF11293C);
}
