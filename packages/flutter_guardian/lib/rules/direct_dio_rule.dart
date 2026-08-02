import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// HTTP goes through Retrofit's `RestClient`; calling `Dio` methods
/// directly bypasses the interceptor pipeline (auth, refresh, error
/// attachment). Only the network layer itself may touch the transport.
class DirectDioRule extends AnalysisRule {
  DirectDioRule()
    : super(
        name: 'direct_dio_call',
        description:
            'Call Retrofit RestClient methods, never Dio directly — direct '
            'calls bypass the interceptor pipeline.',
      );

  static const LintCode code = LintCode(
    'direct_dio_call',
    'Direct Dio calls bypass the interceptor pipeline.',
    correctionMessage: 'Add an endpoint to RestClient and call that instead.',
    severity: DiagnosticSeverity.WARNING,
  );

  static const _httpMethods = {
    'get',
    'post',
    'put',
    'delete',
    'patch',
    'head',
    'fetch',
    'request',
    'download',
  };

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addMethodInvocation(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final DirectDioRule rule;
  final RuleContext context;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final path = (context.currentUnit ?? context.definingUnit).file.path;
    // The network layer owns the transport; everything in it may call Dio.
    if (path.contains('/data/services/network/')) return;
    if (!DirectDioRule._httpMethods.contains(node.methodName.name)) return;

    final targetType = node.realTarget?.staticType;
    if (targetType == null) return;
    if (targetType.getDisplayString() == 'Dio') {
      rule.reportAtNode(node);
    }
  }
}
