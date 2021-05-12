import 'package:data/data.dart';
import 'package:example/blocs/home/home.dart';
import 'package:example/helpers/ui_helper.dart';
import 'package:example/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:example/extensions/extensions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CardAccountWidget extends StatelessWidget {
  final AccountModel accountModel;
  final HomeBloc homeBloc;

  CardAccountWidget({Key key, this.accountModel, this.homeBloc})
      : super(key: key);

  final recipientController = TextEditingController();
  final amountController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                            '\$${accountModel.amount}' ?? '',
                            style: theme.textTheme.headline4.bold,
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalBox16,
                    _buildListPenddingTransaction(
                        theme, accountModel.listTransaaction),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildBottomBar(theme, context),
                ),
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
                      '${accountModel.amount} ',
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

  Widget _buildBottomBar(ThemeData theme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.maxFinite,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: MyColors.gray.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: MyColors.card,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.arrow_circle_down_outlined,
                  color: MyColors.primaryWhite,
                ),
              ),
              UIHelper.verticalBox6,
              Text('Receive', style: theme.textTheme.bodyText2),
            ],
          ),
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: MyColors.card,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  Icons.add_circle_outline,
                  color: MyColors.primaryWhite,
                ),
              ),
              UIHelper.verticalBox6,
              Text('Buy ZPICoin', style: theme.textTheme.bodyText2),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  showCupertinoModalBottomSheet(
                      context: context,
                      expand: false,
                      builder: (context) => Scaffold(
                            body: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    UIHelper.verticalBox12,
                                    Center(
                                      child: Text(
                                        'Send',
                                        style: theme.textTheme.headline6,
                                      ),
                                    ),
                                    Padding(
                                      padding: UIHelper.paddingAll16,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: double.maxFinite,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'to:  ',
                                                  style:
                                                      theme.textTheme.bodyText2,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        recipientController,
                                                    decoration: InputDecoration(
                                                      hintText: '0x...address',
                                                      labelStyle: new TextStyle(
                                                          color: MyColors.red),
                                                      hintStyle: theme
                                                          .textTheme.bodyText2
                                                          .textColor(
                                                        MyColors.gray
                                                            .withOpacity(0.7),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          UIHelper.verticalBox24,
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: theme.textTheme
                                                      .bodyText1.size20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${accountModel.amount} ',
                                                          style: theme.textTheme
                                                              .bodyText1.size16,
                                                        ),
                                                        Text('ZPICoin',
                                                            style: theme
                                                                .textTheme
                                                                .bodyText2
                                                                .size12),
                                                      ],
                                                    ),
                                                    Text(
                                                      '${accountModel.amount * 3}\$',
                                                      style: theme.textTheme
                                                          .bodyText2.size10,
                                                    ),
                                                  ],
                                                )
                                              ])
                                        ],
                                      ),
                                    ),

                                    // input number of coin

                                    Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      width: 200,
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              controller: amountController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: theme.textTheme.headline4,
                                              cursorColor: MyColors.card,
                                              decoration: InputDecoration(
                                                hintText: '0.0',
                                                hintStyle: theme
                                                    .textTheme.headline4
                                                    .textColor(MyColors.gray
                                                        .withOpacity(0.5)),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'ZPICoin',
                                              style: theme
                                                  .textTheme.headline5.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // fee
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: () {
                                      homeBloc.sendCoin(
                                        amount: amountController.text.toInt(),
                                        privateKey: accountModel.privateKey,
                                        sender: accountModel.publicKey,
                                        recipient: recipientController.text,
                                      );
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        EasyLoading.showSuccess(
                                            'transaction completed ',
                                            duration: Duration(seconds: 1));
                                        homeBloc.loadData();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.card,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      width: double.maxFinite,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          'Send',
                                          style: theme.textTheme.bodyText1
                                              .textColor(
                                            MyColors.primaryWhite,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyColors.card,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    Icons.arrow_circle_up_outlined,
                    color: MyColors.primaryWhite,
                  ),
                ),
              ),
              UIHelper.verticalBox6,
              Text('Send', style: theme.textTheme.bodyText2),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListPenddingTransaction(
      ThemeData theme, List<TransactionResponse> list) {
    return Container(
      padding: UIHelper.horizontalEdgeInsets16,
      height: 390,
      child: list.isNotNullOrEmpty
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list?.length ?? 0,
              itemBuilder: (context, index) {
                final transaction = list[index];
                return Column(
                  children: [
                    _buildTransactionItem(theme, transaction.sender,
                        transaction.recipient, transaction.amount),
                    // Divider(
                    //   thickness: 2,
                    // ),
                    UIHelper.verticalBox20
                  ],
                );
              })
          : Center(
              child: Text(
                'No transactions yet',
                style: theme.textTheme.bodyText2.size18,
              ),
            ),
    );
  }

  Widget _buildTransactionItem(
      ThemeData theme, String sender, String recipient, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Sender: ', style: theme.textTheme.bodyText2.semiBold),
                Text(
                    '${sender.substring(0, 5)} . . . ${sender.substring(sender.length - 10, sender.length - 1)}',
                    style: theme.textTheme.bodyText2),
              ],
            ),
            UIHelper.verticalBox4,
            Row(
              children: [
                Text('recipient: ', style: theme.textTheme.bodyText2.semiBold),
                Text(
                    '${recipient.substring(0, 5)} . . . ${recipient.substring(sender.length - 10, sender.length - 1)}',
                    style: theme.textTheme.bodyText2),
              ],
            ),
          ],
        ),
        Text('\$ $amount',
            style: theme.textTheme.bodyText2.size20.semiBold
                .textColor(MyColors.card)),
      ],
    );
  }
}
