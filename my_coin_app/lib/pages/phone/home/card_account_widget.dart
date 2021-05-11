import 'package:data/data.dart';
import 'package:example/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:example/extensions/extensions.dart';

class CardAccountWidget extends StatelessWidget {
  final AccountModel accountModel;
  const CardAccountWidget({Key key, this.accountModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 160,
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: MyColors.card,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accountModel.accountName ?? '',
                style:
                    theme.textTheme.bodyText2.textColor(MyColors.primaryWhite),
              ),
              Text(
                accountModel.publicKey,
                style: theme.textTheme.bodyText2.textColor(MyColors.gray),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
