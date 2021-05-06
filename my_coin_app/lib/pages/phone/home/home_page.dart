import 'package:flutter/material.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../../../blocs/blocs.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;

  HomePage(this.bloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {

  @override
  Widget buildContent(BuildContext context) {
    return Container();
  }

  @override
  HomeBloc get bloc => widget.bloc;
}
