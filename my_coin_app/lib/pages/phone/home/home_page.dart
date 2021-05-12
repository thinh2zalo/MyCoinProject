import 'package:data/data.dart';
import 'package:example/helpers/helpers.dart';
import 'package:example/pages/phone/home/card_account_widget.dart';
import 'package:example/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../blocs/blocs.dart';
import 'package:example/extensions/extensions.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomeBloc bloc;
  HomePage(this.bloc);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  final _accountController = TextEditingController();
  bool isNameEmpty = false;
  @override
  void loadData() {
    if (isFirstInit) {}
    bloc.loadData();
  }

  Widget _appBar(ThemeData theme) {
    return Row(
      children: <Widget>[
        Text('Wallet,', style: theme.textTheme.headline5.bold),
        Expanded(
          child: SizedBox(),
        ),
        Icon(
          Icons.short_text,
          color: Theme.of(context).iconTheme.color,
        )
      ],
    );
  }

  Widget _buildListCard(ThemeData theme) {
    return StreamBuilder<List<AccountModel>>(
        stream: bloc.listAccount$,
        builder: (context, snapshot) {
          final length = snapshot?.data?.length ?? 0;
          final listAccount = snapshot?.data ?? [];
          return Container(
            width: double.maxFinite,
            height: 160,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: length + 1,
              itemBuilder: (context, index) {
                if (index == length) {
                  return _buildCreateWallet(theme);
                } else
                  return CardAccountWidget(
                    accountModel: listAccount[index],
                    homeBloc: bloc,
                  );
              },
            ),
          );
        });
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

  Widget _buildCreateWallet(ThemeData theme) {
    return Container(
      height: 160,
      width: 250,
      child: InkWell(
        onTap: () {
          showCupertinoModalBottomSheet(
            context: context,
            expand: false,
            builder: (context) => Scaffold(
              body: Container(
                padding: UIHelper.paddingAll24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add account',
                          style: theme.textTheme.headline5.bold,
                        ),
                        TextFormField(
                          cursorColor: MyColors.card,
                          controller: _accountController,
                          decoration: InputDecoration(
                              hintText: 'Account nickname',
                              hintStyle: theme.textTheme.headline6
                                  .textColor(MyColors.gray.withOpacity(0.5))),
                        ),
                        UIHelper.verticalBox6,
                        Text(
                          'Example: Private funds, savings account, dApp account, Work funds, Airdrops',
                          style: theme.textTheme.bodyText1.size10
                              .textColor(MyColors.black.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: isNameEmpty
                            ? null
                            : () {
                                bloc.createWallet(_accountController.text);
                                EasyLoading.show();

                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  EasyLoading.showSuccess('Great Success!',
                                      duration: Duration(seconds: 1));
                                });

                                Navigator.pop(context);
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                isNameEmpty ? MyColors.bg_gray : MyColors.card,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          width: double.maxFinite,
                          height: 50,
                          child: Center(
                            child: Text(
                              'Add',
                              style: theme.textTheme.bodyText1.textColor(
                                isNameEmpty
                                    ? MyColors.black.withOpacity(0.6)
                                    : MyColors.primaryWhite,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
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
                Icon(
                  Icons.add_circle_rounded,
                  size: 35,
                  color: MyColors.primaryWhite,
                ),
                Text(
                  'Add account',
                  style: theme.textTheme.headline6.bold
                      .textColor(MyColors.primaryWhite),
                ),
                Text(
                  'to manage your stacks separately',
                  style: theme.textTheme.bodyText2
                      .size(10)
                      .textColor(MyColors.primaryWhite),
                ),
                Text(
                  'For example',
                  style: theme.textTheme.bodyText2
                      .size(10)
                      .textColor(MyColors.gray),
                ),
                Text(
                  'day-to-day payments, Long-tern savings, dApp play funds',
                  style: theme.textTheme.bodyText2.size10
                      .textColor(MyColors.primaryWhite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTradingActivities(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 160,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            color: MyColors.primaryWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_circle_down_outlined,
                  size: 40,
                ),
                Text(
                  'Receive',
                  style: theme.textTheme.bodyText1.bold,
                ),
                Text(
                  'From existing wallet',
                  style: theme.textTheme.bodyText2,
                )
              ],
            ),
          ),
        ),
        UIHelper.verticalBox6,
        InkWell(
          child: Container(
            height: 120,
            width: 160,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: MyColors.primaryWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 40,
                  ),
                  Text(
                    'Buy Ether',
                    style: theme.textTheme.bodyText1.bold,
                  ),
                  Text(
                    'Visa or MasterCard',
                    style: theme.textTheme.bodyText2,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 35),
              _appBar(theme),
              UIHelper.verticalBox6,
              Text(
                "TOTAL PORTFOLIO VALUE",
                style: theme.textTheme.bodyText2.size10,
              ),
              UIHelper.verticalBox6,
              Text("0.00", style: theme.textTheme.bodyText1.bold),
              _buildListCard(theme),
              Text(
                'Manage account',
                style: theme.textTheme.bodyText1,
              ),
              UIHelper.verticalBox16,
              _buildTradingActivities(theme),
              UIHelper.verticalBox16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pendding Transaction',
                    style: theme.textTheme.headline6.bold,
                  ),
                  InkWell(
                    onTap: () {
                      bloc.mining();
                      EasyLoading.show();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        EasyLoading.showSuccess('Great Success!',
                            duration: Duration(seconds: 1));
                      });
                      bloc.loadData();
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColors.card,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Mine',
                        style: theme.textTheme.bodyText2.primaryWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalBox16,
              StreamBuilder<List<TransactionResponse>>(
                  stream: bloc.listTransaction$,
                  builder: (context, snapshot) {
                    print('snapshot ${snapshot?.data?.length}');
                    final list = snapshot?.data ?? [];
                    return _buildListPenddingTransaction(theme, list);
                  }),
            ],
          )),
    )));
  }

  Widget _buildListPenddingTransaction(
      ThemeData theme, List<TransactionResponse> list) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
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
          }),
    );
  }

  @override
  HomeBloc get bloc => widget.bloc;
}
