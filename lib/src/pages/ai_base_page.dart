import 'package:flutter/material.dart';
import '../models/ai_display_area_model.dart';
import '../models/ai_base_model.dart';

// ignore: must_be_immutable
abstract class AiBaseStatelessWidget extends StatelessWidget {
  AiBaseStatelessWidget({Key key}) : super(key: key);
  // get device width and height
  double get dvWidth => AiDisplayAreaModel.displayWidth;
  double get dvHeight => AiDisplayAreaModel.displayHeight;
  Size get dvSize => AiDisplayAreaModel.displaySize;
  BuildContext pageContext;

  @protected
  Widget internalBuild(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    pageContext = context;
    if (!AiDisplayAreaModel.initialized) AiDisplayAreaModel.instance.init(context);
    return internalBuild(context);
  }

  void debug(dynamic aObject) {
    if (AiDebugger.instance.isLogEnabled && aObject != null) print('Debugging from AI Class name : ${this.runtimeType} - $aObject');
  }
}

/* ------------------------------------------------------------------------------- */

// ignore: must_be_immutable
abstract class AiBaseStatefulWidget extends StatefulWidget {
  AiBaseStatefulWidget({Key key}) : super(key: key);
}

abstract class AiBaseState<Page extends AiBaseStatefulWidget> extends State<Page> {
  // get device width and height
  double get dvWidth => AiDisplayAreaModel.displayWidth;
  double get dvHeight => AiDisplayAreaModel.displayHeight;
  Size get dvSize => AiDisplayAreaModel.displaySize;
  BuildContext pageContext;

  @override
  void initState() {
    super.initState();
    pageContext = context;
  }

  @protected
  Widget internalBuild(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // pageContext = context;
    if (!AiDisplayAreaModel.initialized) AiDisplayAreaModel.instance.init(context);
    return internalBuild(context);
  }

  void debug(dynamic aObject) {
    if (AiDebugger.instance.isLogEnabled && aObject != null) print('Debugging from AI Class name : ${this.runtimeType} - $aObject');
  }
}

/* ------------------------------------------------------------------------------- */
