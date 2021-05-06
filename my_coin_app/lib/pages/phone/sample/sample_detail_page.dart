import 'package:flutter/material.dart';
import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import '../../../blocs/blocs.dart';
import '../../../models/model.dart';

class SampleDetailPage extends StatefulWidget {
  final SampleDetailBloc bloc;

  SampleDetailPage(this.bloc);

  @override
  _SampleDetailPageState createState() => _SampleDetailPageState();
}

class _SampleDetailPageState extends BaseState<SampleDetailPage, SampleDetailBloc> {

  @override
  void initState() {
    bloc?.listenerStream?.listen((event) {
      if (event != null && event is EventModel) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Thong bao'),
              content: Text(localizations.text(event.message)),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) {
          Navigator.of(context).pop();
        });
      }
    });
    super.initState();
  }

  @override
  void onNavigateAsync(Object payload) {
    bloc.loadData(payload as String);
  }

  @override
  Widget buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(icon: const Icon(Icons.delete), onPressed: bloc.delete),
        IconButton(icon: const Icon(Icons.edit), onPressed: bloc.update),
      ],
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return StreamBuilder<SampleEntity>(
      stream: bloc.stateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final entity = snapshot.data;
          if (entity != null) {
            return Center(
              child: Text(
                entity.productName,
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          } else {
            return Container();
          }
        }
        return Container();
      },
    );
  }

  @override
  SampleDetailBloc get bloc => widget.bloc;
}
