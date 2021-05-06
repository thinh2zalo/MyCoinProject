import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import '../../../blocs/blocs.dart';
import '../../../router/router.dart';
import '../../../resources/resources.dart';

class SamplePage extends StatefulWidget {
  final SampleBloc bloc;

  SamplePage(this.bloc);

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends BaseState<SamplePage, SampleBloc> {
  @override
  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(localizations.text('ui.app_name')),
      actions: [
        IconButton(
          onPressed: () {
            bloc.loadData();
          },
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return StreamBuilder<List<SampleModel>>(
      stream: bloc.stateStream,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text('Error'),
          );
        else if (snapshot.hasData) {
          final items = snapshot.data;
          return ListView.builder(
            itemCount: items?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.sampleDetail, arguments: items[index].id).then((value) => bloc.reload());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size8),
                  child: Text(items[index].productName),
                ),
              );
            },
          );
        } else
          return Container();
      },
    );
  }

  @override
  SampleBloc get bloc => widget.bloc;

  @override
  void loadData() {
    bloc.loadData();
  }
}
