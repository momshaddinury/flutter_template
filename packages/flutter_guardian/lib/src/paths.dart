import 'package:analyzer/analysis_rule/rule_context.dart';

/// The path of the unit being visited, in posix form.
///
/// Every rule matches its scope against `/`-joined markers, so the path
/// has to arrive in that shape. Use this rather than reading
/// `file.path` directly.
///
/// The fallback to `definingUnit` matters for the DI files, which are
/// `part` files: the defining unit resolves to the library, while the
/// unit being visited is the one whose path names the layer.
String posixPath(RuleContext context) =>
    toPosix((context.currentUnit ?? context.definingUnit).file.path);

/// Rewrites native separators to `/`.
///
/// The analyzer reports paths in the host convention, so on Windows a
/// file arrives as `C:\repo\lib\src\...`. Left alone, every marker match
/// in every rule silently fails there — the scope checks never match, so
/// a rule either goes quiet or loses the exemption that keeps it quiet.
String toPosix(String path) => path.replaceAll(r'\', '/');
