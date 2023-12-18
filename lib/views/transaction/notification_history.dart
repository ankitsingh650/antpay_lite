
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../model/notification/notification_model.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import '../../utils/widgets/list_view_tile.dart';

class NotificationHistory extends StatefulWidget {
  const NotificationHistory({super.key});

  @override
  State<NotificationHistory> createState() => _NotificationHistoryState();
}

class _NotificationHistoryState extends State<NotificationHistory> {
  bool hasRecords=true;
  List <Notifications>? _notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 30,
          width: 130,
          child: Image.asset('assets/images/antpaybizhub_logo.png'),
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
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: NotificationHistory(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Expanded(
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.all(8),
                  child: hasRecords? Column(
                    children: [
                      Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                    child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          return NotificationItemTile(
                                            onTap: (){
                                              print('Notification Clicked');
                                            },
                                            imageUrl: _notifications![index].imgUrl.toString(),
                                            titleText: _notifications![index].title.toString(),
                                            body: _notifications![index].createdDate.toString(),

                                          );
                                        },
                                        itemCount:_notifications?.length,//_statement?.length
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ) : Center(child: Text(
                    "No Notifications Found",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),)),
                )),
          ],
        ),
      ),
    );
  }

  void _initNotifications() async{
    CommonApiRepo repoClass = CommonApiRepo();

    FetchNotificationResponseModel response= await repoClass.getNotifications(SessionManager().getMobile().toString());

    if(response.status.toString()=="1"){
      print('List::${response.notificationList}');
      List<Notifications>?firstNotifications=response.notificationList;
      _notifications?.addAll(firstNotifications!);
      setState(() {
        hasRecords=true;
      });
    }
    else{
      setState(() {
        hasRecords=false;
      });
      print("No Response");
    }
  }
}
