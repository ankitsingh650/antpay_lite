
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/transaction/transaction_history_view_model.dart';
import '../../model/post.dart';
import '../../model/transaction/transaction_history_model.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import '../../repository/login/list_data_model.dart';
import '../../res/color_palette.dart';
import '../../utils/method_utils.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/widgets/list_view_tile.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {

  bool dummy=false;
  bool hasRecords=false;
  late TextEditingController fromDate, toDate;

  var keyForm=GlobalKey<FormState>();

  late ScrollController _scrollController;
  late var transactionHistoryViewModel;

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List <Post>_posts = [];
  List <TransactionModel>?_statement = [];

  String? selectedRange;
  String? range;

  String? defFromDate,defToDate;
  List<String> rangeList = ['Today', 'Yesterday', '7 Days', 'Range'];

  bool rangeVisibility=false;
  List<TransactionData> items=[
    TransactionData(title: "ppi-wallet to 9876543012", description: "PAYU", refID: "BIZ987654589", status: "SUCCESS", date: "2023-06-11 13:45:22", amount: "10", isCredit: true),
    TransactionData(title: "Fund Transfer to 9850982732", description: "PAYU", refID: "BIZ9831354589", status: "SUCCESS", date: "2023-06-12 13:45:22", amount: "20", isCredit: true),
    TransactionData(title: "Fund Transfer to 9876523301", description: "PAYU", refID: "BIZ93454589", status: "SUCCESS", date: "2023-06-13 13:45:22", amount: "100", isCredit: true),
    TransactionData(title: "Fund Transfer to 9876510301", description: "WALLET", refID: "BIZ987654589", status: "SUCCESS", date: "2023-06-14 13:45:22", amount: "10", isCredit: true),
    TransactionData(title: "Fund Transfer to 9876510372", description: "WALLET", refID: "BIZ987999589", status: "SUCCESS", date: "2023-06-15 13:45:22", amount: "567", isCredit: true),
    TransactionData(title: "Fund Transfer to 9876510321", description: "PAYU", refID: "BIZ987888589", status: "FAILED", date: "2023-06-16 13:45:22", amount: "10", isCredit: false),
    TransactionData(title: "Fund Transfer to 9876510990", description: "PAYU", refID: "BIZ987777589", status: "SUCCESS", date: "2023-06-17 13:45:22", amount: "700", isCredit: true),
    TransactionData(title: "Fund Transfer to 984565629", description: "WALLET", refID: "BIZ987666689", status: "SUCCESS", date: "2023-06-18 13:45:22", amount: "10", isCredit: true),
    TransactionData(title: "Fund Transfer to 9840989872", description: "PAYU", refID: "BIZ987555589", status: "FAILED", date: "2023-06-19 13:45:22", amount: "50", isCredit: false),
    TransactionData(title: "Fund Transfer to 882798765", description: "WALLET", refID: "BIZ9876222589", status: "SUCCESS", date: "2023-06-20 13:45:22", amount: "10", isCredit: true),
    TransactionData(title: "Fund Transfer to 867898789", description: "PAYU", refID: "BIZ987654589", status: "FAILED", date: "2023-06-21 13:45:22", amount: "330", isCredit: false),
    TransactionData(title: "Fund Transfer to 86784567898", description: "WALLET", refID: "BIZ987654589", status: "SUCCESS", date: "2023-06-22 13:45:22", amount: "300", isCredit: true),
    TransactionData(title: "ppi-wallet to 9876543012", description: "PAYU", refID: "BIZ956784589", status: "FAILED", date: "2023-06-23 13:45:22", amount: "1000", isCredit: false),
  ];

  TextEditingController controller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    toDate = TextEditingController();
    fromDate = TextEditingController();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   _firstLoad();
    // });

    _scrollController= ScrollController()..addListener(dummy?_loadMoreDummy:_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    toDate.dispose();
    fromDate.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    transactionHistoryViewModel=Provider.of<TransactionHistoryViewModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
       /* appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 30,
            width: 130,
            child: Image.asset('assets/images/antpay_logo.png'),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Transform.scale(
              scale: 0.6,
              child: IconButton(
                icon: Image.asset('assets/images/notification_bell.png'),
                onPressed: () {
                  // do something
                  print('Bell Icon');
                  // Navigator.pushNamed(context, RoutesName.notification_history);
                *//*  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: NotificationHistory(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );*//*
                },
              ),
            )
          ],
        ),*/
        body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            SizedBox(height: 20,),
            Expanded(
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.all(8),
                  child: hasRecords? Column(
                    children: [
                      // Container(
                      //   alignment: Alignment.centerLeft,
                      //   margin: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      //   child: Text("Transaction History",
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black,
                      //     ),),
                      // ),
                      Expanded(
                          child: Container(
                            child: _isFirstLoadRunning? const Center(
                              child: const CircularProgressIndicator(),
                            ) : Column(
                              children: [
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   margin: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                                //   child: Text("Transaction History",
                                //     style: TextStyle(
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.black,
                                //     ),),
                                // ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                    child: ListView.builder(
                                        controller: _scrollController,
                                        itemBuilder: (context, index) {
                                          // return MyListViewItem(
                                          //   title: _posts[index].title!,
                                          //   description: "alpha",
                                          //   refID: "12345",
                                          //   status: "SUCCESS",
                                          //   date: "09876",
                                          //   amount: "\u{20B9} ${_posts[index].id}",
                                          //   isCredit: true,
                                          //   // title: "ughuij",
                                          //   // description: "iuyghjk",
                                          //   // refID: "987654345678",
                                          //   // status: "STATUS",
                                          //   // date: "06-July",
                                          //   // amount: "\u{20B9} 500",
                                          //   // isCredit: true,
                                          // );
                                          return TransactionItemTile(
                                            onTap: (){
                                              print('Transaction Clicked');
                                              late Map<String, dynamic>passScreenData;
                                              if(dummy){
                                                passScreenData = {
                                                  'amount': '${_posts[index].id.toString()}00',
                                                };
                                              }
                                              print(_statement![index]);
                                              Navigator.pushNamed(
                                                  context, RoutesName.transaction_item,
                                                  arguments: dummy? passScreenData : _statement![index]);
                                            },
                                            accountNumber: dummy?'Khwaja Faraz': _statement![index].sender.toString(),
                                            settlementStatus: dummy?"PENDING" : _statement![index].settlementStatus.toString(),
                                            date: dummy?"12/04 | 05:35 PM": _statement![index].transactionDate.toString(),
                                            amount: dummy?'\u{20B9} ${_posts[index].id.toString()}' :'\u{20B9} ${_statement![index].transactionAmount}',
                                            isCredit: true,
                                          );
                                        },
                                        itemCount: dummy?_posts.length : _statement?.length
                                    ),
                                  ),
                                ),
                                // when the _loadMore function is running
                                if (_isLoadMoreRunning == true)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10, bottom: 40),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),

                                // When nothing else to load
                                if (_hasNextPage == false)
                                  Container(
                                    padding: const EdgeInsets.only(top: 20, bottom: 20),

                                    decoration: BoxDecoration(
                                        color: ColorPalette.iconColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0)
                                      )
                                    ),
                                    child: const Center(
                                      child: Text('You have fetched all Transactions'),
                                    ),
                                  ),
                              ],
                            ),
                          ))
                    ],
                  ) : Center(child: Text(
                      "No Transactions Found",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),)),
                )),
          ],
        ),
      )
    );
  }


/*  void _firstLoad() async{
    print('Function First Load->$defFromDate::$defToDate');
    bool failed=false;
    setState(() {
      _isFirstLoadRunning = true;
      _hasNextPage=true;
    });

    _statement!.clear();
    _page=0;


    fetchStatementRequestModel requestModel=fetchStatementRequestModel(
      mobile: SessionManager().getMobile().toString(),
      txnStartDate: defFromDate.toString(),//'15-08-2023',
      txnEndDate: defToDate.toString(),//'15-09-2023',
      pageNo: '$_page',
    );
    fetchStatementResponseModel response=await transactionHistoryViewModel.fetchTransactions(context, requestModel);
    if(response.status.toString()=="SUCCESS"){
      print('List::${response.transactionList}');
      List<TransactionModel>?firstStatements=response.transactionList;
      _statement?.addAll(firstStatements!);
      setState(() {
        hasRecords=true;
      });
    }
    else{
      failed=true;
      setState(() {
        hasRecords=false;
      });
      print("No Response");
    }


    setState(() {
      _isFirstLoadRunning = false;
    });

  }*/

  void _firstLoadDummy() async{
    bool failed=false;
    print('Function First Load Dummy->$defFromDate::$defToDate');
    setState(() {
      _isFirstLoadRunning = true;
      _hasNextPage=true;
    });

    _posts!.clear();
    _page=0;

    CommonApiRepo repo=CommonApiRepo();
    List<Post> firstPosts = await repo.fetchPost(_page, _limit);
    _posts.addAll(firstPosts);

    setState(() {
      _isFirstLoadRunning = false;
      hasRecords=true;
    });
  }

  void _loadMore() async {
    print('Function Load More->$defFromDate::$defToDate');
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      print('page no:$_page');
      _page += 1; // Increase _page by 1
      print('page no:$_page');

      final List<TransactionModel>? fetchedTransactionList;

      fetchStatementRequestModel requestModel=fetchStatementRequestModel(
        mobile: SessionManager().getMobile().toString(),
        txnStartDate: defFromDate.toString(),//'15-08-2023',
        txnEndDate: defToDate.toString(),//'15-09-2023',
        pageNo: '$_page',
      );
      fetchStatementResponseModel response=await transactionHistoryViewModel.fetchTransactions(context, requestModel);
      if(response.responseMessage.toString()=="SUCCESS"){
        fetchedTransactionList=response.transactionList;
      }
      else{
        fetchedTransactionList=null;
        print("No Response");
      }

      print('LIST SIZE:${fetchedTransactionList?.length.toString()}');
      setState(() {
        _isLoadMoreRunning = false;
      });
      if(fetchedTransactionList==null){
        setState(() {
          _hasNextPage = false;
        });
      }
      else if(fetchedTransactionList!.isNotEmpty ) {
        setState(() {
          _statement?.addAll(fetchedTransactionList!);
        });
      }
    }
  }

  void _loadMoreDummy() async {
    print('Function Load More Dummy->$defFromDate::$defToDate');
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      print('page no:$_page');
      _page += 1; // Increase _page by 1
      print('page no:$_page');

      CommonApiRepo repo=CommonApiRepo();
      final List<Post> fetchedList;

      fetchedList=await repo.fetchPost(_page, _limit);

      print('LIST SIZE:${fetchedList.length.toString()}');
      setState(() {
        _isLoadMoreRunning = false;
      });
      if(fetchedList.isNotEmpty ){
        setState(() {
          _posts.addAll(fetchedList);
        });
      }
      else if(fetchedList?.length==0){
        setState(() {
          _hasNextPage = false;
        });
      }
    }
  }

  Future openPopUpDialog() => showDialog(context: context,
    builder: (context)=>AlertDialog(
      title: const Text('No Statements'),
      content: const Text(
        'No Transaction Found between the Specified timelinw!',
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutesName.dashboard);
            },
            child: Text(
                'DONE'
            ))
      ],
    ),
  );

  void _executeDateSelection(String? range) {
    switch(range){
      case 'Today':
        setState(() {
          rangeVisibility=false;
        });
        defFromDate=CommonMethodUtils().formatRangeDate(DateTime.now().toString());
        defToDate=CommonMethodUtils().formatRangeDate(DateTime.now().toString());
        print('$defFromDate::$defToDate');
      //  dummy?_firstLoadDummy(): _firstLoad();
        break;
      case 'Yesterday':
        setState(() {
          rangeVisibility=false;
        });
        defFromDate=CommonMethodUtils().formatRangeDate(DateTime.now().subtract(Duration(days: 1)).toString());
        defToDate=CommonMethodUtils().formatRangeDate(DateTime.now().subtract(Duration(days: 1)).toString());
        print('$defFromDate::$defToDate');
      //  dummy?_firstLoadDummy(): _firstLoad();
        break;
      case '7 Days':
        setState(() {
          rangeVisibility=false;
        });
        defFromDate=CommonMethodUtils().formatRangeDate(DateTime.now().subtract(Duration(days: 7)).toString());
        defToDate=CommonMethodUtils().formatRangeDate(DateTime.now().toString());
        print('$defFromDate::$defToDate');
      //  dummy?_firstLoadDummy(): _firstLoad();
        break;
      case 'Range':
        setState(() {
          rangeVisibility=true;
        });
        break;

    }
  }
}
