import 'package:data/data.dart';
import 'package:example/helpers/helpers.dart';
import 'package:example/pages/phone/home/card_account_widget.dart';
import 'package:example/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void loadData() {
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
                  );
              },
            ),
          );
        });
  }

  // Widget _icon(IconData icon, String text) {
  //   return Column(
  //     children: <Widget>[
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.pushNamed(context, '/transfer');
  //         },
  //         child: Container(
  //           height: 80,
  //           width: 80,
  //           margin: EdgeInsets.symmetric(vertical: 10),
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.all(Radius.circular(20)),
  //               boxShadow: <BoxShadow>[
  //                 BoxShadow(
  //                     color: Color(0xfff3f3f3),
  //                     offset: Offset(5, 5),
  //                     blurRadius: 10)
  //               ]),
  //           child: Icon(icon),
  //         ),
  //       ),
  //       Text(text,
  //           style: GoogleFonts.muli(
  //               textStyle: Theme.of(context).textTheme.display1,
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //               color: Color(0xff76797e))),
  //     ],
  //   );
  // }

  // Widget _transectionList() {
  //   return Column(
  //     children: <Widget>[
  //       _transection("Flight Ticket", "23 Feb 2020"),
  //       _transection("Electricity Bill", "25 Feb 2020"),
  //       _transection("Flight Ticket", "03 Mar 2020"),
  //     ],
  //   );
  // }

  // Widget _transection(String text, String time) {
  //   return ListTile(
  //     leading: Container(
  //       height: 50,
  //       width: 50,
  //       decoration: BoxDecoration(
  //         color: MyColors.navyBlue1,
  //         borderRadius: BorderRadius.all(Radius.circular(10)),
  //       ),
  //       child: Icon(Icons.hd, color: Colors.white),
  //     ),
  //     contentPadding: EdgeInsets.symmetric(),
  //     title: Text(
  //       text,
  //     ),
  //     subtitle: Text(time),
  //     trailing: Container(
  //         height: 30,
  //         width: 60,
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           color: MyColors.lightGrey,
  //           borderRadius: BorderRadius.all(Radius.circular(10)),
  //         ),
  //         child: Text('-20 MLR',
  //             style: GoogleFonts.muli(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold,
  //                 color: MyColors.navyBlue2))),
  //   );
  // }

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
                        TextField(
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
                        onPressed: () {
                          bloc.createWallet(_accountController.text);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.bg_gray,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          width: double.maxFinite,
                          height: 40,
                          child: Center(
                            child: Text(
                              'Add',
                              style: theme.textTheme.bodyText1,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 140,
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
        Expanded(
          child: InkWell(
            child: Container(
              height: 120,
              width: 140,
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
              ),
              UIHelper.verticalBox16,
              _buildTradingActivities(theme),
            ],
          )),
    )));
  }

  @override
  HomeBloc get bloc => widget.bloc;
}
