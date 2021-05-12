import 'package:data/data.dart';
import 'package:example/helpers/ui_helper.dart';
import 'package:example/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:example/extensions/extensions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CardAccountWidget extends StatelessWidget {
  final AccountModel accountModel;
  const CardAccountWidget({Key key, this.accountModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final publicKey = accountModel.publicKey;

    return InkWell(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          expand: false,
          builder: (context) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.add_circle_rounded,
                    size: 40,
                  ),
                  title: Text(
                    accountModel.accountName ?? '',
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    '${publicKey.substring(0, 4)} . . . ${publicKey.substring(publicKey.length - 15, publicKey.length - 1)}' ??
                        '',
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: UIHelper.horizontalEdgeInsets16,
                  child: Column(
                    children: [
                      Text(
                        '\$ ${accountModel.amount}' ?? '',
                        style: theme.textTheme.headline4.bold,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      child: Container(
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
                  style: theme.textTheme.bodyText2
                      .textColor(MyColors.primaryWhite),
                ),
                UIHelper.verticalBox6,
                Text(
                  '${publicKey.substring(0, 4)} . . . ${publicKey.substring(publicKey.length - 15, publicKey.length - 1)}',
                  style: theme.textTheme.bodyText2
                      .textColor(MyColors.primaryWhite.withOpacity(0.6)),
                ),
                UIHelper.verticalBox6,
                Row(
                  children: [
                    Text(
                      '${accountModel.amount}',
                      style: theme.textTheme.headline4.bold
                          .textColor(MyColors.primaryWhite),
                    ),
                    Icon(Icons.arrow_right, color: MyColors.primaryWhite)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
