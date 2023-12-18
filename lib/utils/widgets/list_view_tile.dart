import 'package:flutter/material.dart';

import '../../res/color_palette.dart';
import '../common_utils.dart';

class MyListViewItem extends StatefulWidget {
  final String title;
  final String description;
  final String refID;
  final String status;
  final String date;
  final String amount;
  final bool isCredit;

  MyListViewItem({
    required this.title,
    required this.description,
    required this.refID,
    required this.status,
    required this.date,
    required this.amount,
    required this.isCredit,
  });

  @override
  _MyListViewItemState createState() => _MyListViewItemState();
}

class _MyListViewItemState extends State<MyListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,

        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.refID,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.status,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.date,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: widget.isCredit?const AssetImage('assets/images/plus.png'):const AssetImage('assets/images/minus.png'),
                        ),
                      ),
                      Text(
                        widget.amount,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// my custom TransactionItemTileWidget

class TransactionItemTile extends StatefulWidget{
  final String accountNumber;
  final String settlementStatus;
  final String date;
  final String amount;
  final bool isCredit;
  final VoidCallback? onTap;

  TransactionItemTile({
    required this.accountNumber,
    required this.settlementStatus,
    required this.date,
    required this.amount,
    required this.isCredit,
    this.onTap,
  });

  @override
  _TransactionItemTileState createState() => _TransactionItemTileState();

}

class _TransactionItemTileState extends State<TransactionItemTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: CommonUtils.toColor('#F3F3F3'),
              width: 1, //<-- SEE HERE
            )),
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 4.0,top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundImage: widget.isCredit?const AssetImage('assets/images/plus.png'):const AssetImage('assets/images/minus.png'),
                          ),
                        ),
                        Text(
                          widget.accountNumber,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.settlementStatus,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.date,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black12,
                          ),
                        ),

                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.amount,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}

//item in profile tab
class ProfileListItemTile extends StatefulWidget {
  final String imagePath;
  final String text;
  final VoidCallback? onTap;

  const ProfileListItemTile({
    Key? key,
    required this.imagePath,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  _ProfileListItemTileState createState() => _ProfileListItemTileState();
}

class _ProfileListItemTileState extends State<ProfileListItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(widget.imagePath),
                    width: 16,
                    height: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4, right: 8.0, bottom: 8.0),
                  child: Text(
                    widget.text,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/images/right_arrow.png'),
                    width: 14,
                    height: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Business Loan History item Tile

class LoanItemTile extends StatefulWidget {
  final String date;
  final String id;
  final String status;
  final VoidCallback? onTap;

  LoanItemTile({
    required this.date,
    required this.id,
    required this.status,
    this.onTap,
  });

  @override
  State<LoanItemTile> createState() => _LoanItemTileState();
}

class _LoanItemTileState extends State<LoanItemTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            height: 180,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1),
                ]),
            child:Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    color: CommonUtils.toColor('#06476f'),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                   "Application ID",//CommonMethodUtils().showLoanDate(widget.date.toString()),
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    widget.id,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                              const Text(
                                                "Date of Application: ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                child: Text(
                                                  widget.date.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                    ],
                                  ),
                                  const SizedBox(height: 7,),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                              Text(
                                                "Loan Type: ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                                child: Text(
                                                  "Business Loan",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                    ],
                                  ),
                                ],
                              ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                    color: CommonUtils.toColor('#cddae2'),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                              "View Loan Status",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            )
            // Stack(
            //   children: [
            //     Positioned(
            //         top: 0,
            //         left: 0,
            //         right: 0,
            //         child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                           // Text(
            //                           //   "Date of Application: ",
            //                           //   style: TextStyle(
            //                           //     fontSize: 12,
            //                           //     fontWeight: FontWeight.normal,
            //                           //     color: Colors.white,
            //                           //   ),
            //                           // ),
            //                           Text(
            //                            "Application ID",//CommonMethodUtils().showLoanDate(widget.date.toString()),
            //                            maxLines: 2,
            //                            overflow: TextOverflow.ellipsis,
            //                             textAlign: TextAlign.left,
            //                             style: TextStyle(
            //                               fontSize: 16,
            //                               fontWeight: FontWeight.bold,
            //                               color: Colors.white,
            //                             ),
            //                           ),
            //                 ],
            //               ),
            //               Text(
            //                 widget.id,
            //                 textAlign: TextAlign.left,
            //                 style: TextStyle(
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )),
            //     Positioned(
            //       top: 85,
            //         child: Container(
            //           width: MediaQuery.of(context).size.width*0.85,
            //           padding: EdgeInsets.symmetric(horizontal: 4),
            //           child: Column(
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                           Text(
            //                             "Date of Application: ",
            //                             style: TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.normal,
            //                               color: Colors.grey,
            //                             ),
            //                           ),
            //                           Spacer(),
            //                           Padding(
            //                             padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //                             child: Text(
            //                               widget.date.toString(),
            //                               maxLines: 2,
            //                               overflow: TextOverflow.ellipsis,
            //                               textAlign: TextAlign.right,
            //                               style: TextStyle(
            //                                 fontSize: 18,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black,
            //                               ),
            //                             ),
            //                           ),
            //                 ],
            //               ),
            //               SizedBox(height: 7,),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                           Text(
            //                             "Loan Type: ",
            //                             style: TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.normal,
            //                               color: Colors.grey,
            //                             ),
            //                           ),
            //                           Spacer(),
            //                           Padding(
            //                             padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //                             child: Text(
            //                               "Business Loan",
            //                               maxLines: 2,
            //                               overflow: TextOverflow.ellipsis,
            //                               textAlign: TextAlign.right,
            //                               style: TextStyle(
            //                                 fontSize: 18,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black,
            //                               ),
            //                             ),
            //                           ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         )),
            //
            //     Positioned(
            //       top: 210,
            //       right: 5,
            //       child: Text(
            //       "View Loan Status",
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black,
            //       ),
            //     ))
            //   ],
            // )
        ),
      ),
    );
  }
}

//Business Loan History item Tile

class LenderItemTile extends StatefulWidget {
  final String lenderName;
  final String amountApproved;
  final String lenderStatus;
  final String lenderRemarks;

  LenderItemTile({
    required this.lenderName,
    required this.amountApproved,
    required this.lenderStatus,
    required this.lenderRemarks,
  });

  @override
  State<LenderItemTile> createState() => _LenderItemTileState();
}

class _LenderItemTileState extends State<LenderItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        height: 170,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1),
            ]),
        child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lender's Name: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    // CommonMethodUtils().showLoanDate(widget.date.toString()),
                    widget.lenderName,//"Muthoot Finance",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                height: 50, // Adjust the height as needed
                width: 1,    // Width of the vertical divider
                color: Colors.grey,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Amount: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    // CommonMethodUtils().showLoanDate(widget.date.toString()),
                    widget.amountApproved,//"10,00,000",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Text(
                  // widget.status.toString(),
                  widget.lenderStatus,//"Pending",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Remarks: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Text(
                  widget.lenderRemarks,//"Business Loan",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "*Response as per the Lender's Criteria",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}


// Custom cardView for investment Scheme

class CustomSchemeListTile extends StatefulWidget {
  final String schemeName;
  final String coolingPeriod;
  final String interestRate;
  final String bannerText;
  final String minimumInvestmentAmount;
  final String maximumInvestmentAmount;
  final String preMatRate;
  final bool isVisiblePreMateRte;
  final bool isVisibleLockin;
  final String lockinPeriod;
  final VoidCallback? onTap;

  const CustomSchemeListTile({
    required this.schemeName,
    required this.coolingPeriod,
    required this.interestRate,
    required this.bannerText,
    required this.minimumInvestmentAmount,
    required this.maximumInvestmentAmount,
    required this.preMatRate,
    required this.isVisiblePreMateRte,
    required this.isVisibleLockin,
    required this.lockinPeriod,
    required this.onTap,
  });

  @override
  _CustomSchemeListTile createState() => _CustomSchemeListTile();
}

class _CustomSchemeListTile extends State<CustomSchemeListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      margin: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.schemeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 8, top: 8.0),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 8.0),
                                child: Text(
                                  widget.coolingPeriod,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, top: 4.0),
                                child: Text(
                                  widget.interestRate,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, top: 4.0),
                                child: Text(
                                  widget.minimumInvestmentAmount,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Icon(
                                  Icons.check_circle,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 4.0),
                                child: Text(
                                  widget.maximumInvestmentAmount,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: widget.isVisibleLockin,
                            //(widget.lockinPeriod==null)?false:true,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 4.0),
                                  child: Text(
                                    widget.lockinPeriod,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ColorPalette.bottomIconSelectedColor),
                          minimumSize: MaterialStateProperty.all(const Size(10, 30)),
                          elevation: MaterialStateProperty.all(4),
                          shadowColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Text(
                          'Invest Now',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: widget.onTap,
                      ),
                    ],
                  ),
                  const SizedBox(width: 15.0),
                  Visibility(
                    visible: widget.isVisiblePreMateRte,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.preMatRate,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 140.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/invest_bg.png'),
                      // You should provide the actual image path
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.bannerText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PastInvestmentListTile extends StatefulWidget {
  final String investementNumber;
  final String investementAmount;
  final String investmentDate;
  final String redemptionDate;

  const PastInvestmentListTile(
      {
      required this.investementNumber,
      required this.investementAmount,
      required this.investmentDate,
      required this.redemptionDate});

  @override
  State<PastInvestmentListTile> createState() => _PastInvestmentListTileState();
}

class _PastInvestmentListTileState extends State<PastInvestmentListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0,
      margin: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16,right: 16),
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16.0,left:8.0),
                  child: Text(
                    widget.investementNumber,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Investment Amt',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Investment Date',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),


              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0,top:0.0,right: 8.0),
                  child: Text(
                    widget.investementAmount,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                  child: Text(
                    widget.investmentDate,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Redemption Date',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0,bottom: 8.0),
                  child: Text(
                    widget.redemptionDate,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentInvestmentListTile extends StatefulWidget {
  final String investementNumber;
  final String investementAmount;
  final String interestValue;
  final String investmentDate;
  final String interestRate;
  final VoidCallback? onTap;

  const CurrentInvestmentListTile(
      {
        required this.investementNumber,
        required this.investementAmount,
        required this.interestValue,
        required this.investmentDate,
        required this.interestRate,
        required this.onTap});

  @override
  State<CurrentInvestmentListTile> createState() => _CurrentInvestmentListTileState();
}

class _CurrentInvestmentListTileState extends State<CurrentInvestmentListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0,
      margin: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 16,right: 16),
      child: InkWell(
        onTap:  () {
          widget.onTap!();
        },
        child: Container(
          height: MediaQuery.of(context).size.height*0.30,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:16.0,left:8.0),
                    child: Text(
                      widget.investementNumber,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Invest changed",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Investment Amt',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Interest value',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                    child: Text(
                      widget.investementAmount,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                    child: Text(
                      widget.interestValue,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Investment date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Interest Rate',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                    child: Text(
                      widget.investmentDate,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                    child: Text(
                      widget.interestRate,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

//Notification History Tile

class NotificationItemTile extends StatefulWidget{
  final String imageUrl;
  final String titleText;
  final String body;
  final VoidCallback? onTap;

  NotificationItemTile({
    required this.imageUrl,
    required this.titleText,
    required this.body,
    this.onTap,
  });

  @override
  _NotificationItemTileState createState() => _NotificationItemTileState();

}

class _NotificationItemTileState extends State<NotificationItemTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: CommonUtils.toColor('#F3F3F3'),
              width: 1, //<-- SEE HERE
            )),
        elevation: 1,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),

                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      widget.imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/qr_thumbnail_footer.png', // Replace with the path to your default image asset.
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover, // Adjust the fit as needed.
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(widget.titleText,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(widget.body,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}


// collect Request List Tile

class CollectRequestListTile extends StatefulWidget {
  final String requestRefrenceNumber;
  final String amount;
  final String transcationStatus;
  final String responseMessage;
  final VoidCallback? onTap;

  const CollectRequestListTile(
      {
        required this.requestRefrenceNumber,
        required this.amount,
        required this.transcationStatus,
        required this.responseMessage,
        required this.onTap});

  @override
  State<CollectRequestListTile> createState() => _CollectRequestListTileState();
}

class _CollectRequestListTileState extends State<CollectRequestListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0,
      margin: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8,right: 8),
      child: InkWell(
        onTap:  () {
          widget.onTap!();
        },
        child: Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 8,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.requestRefrenceNumber,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.amount,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),


                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                    child: Text(
                      widget.transcationStatus,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.transcationStatus.toLowerCase()=='success'?Colors.green:((widget.transcationStatus.toLowerCase()=='failure')||(widget.transcationStatus.toLowerCase()=='declined')|| (widget.transcationStatus.toLowerCase()=='expired'))?Colors.red:Colors.orange,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,top:0.0,right:8.0),
                    child: Text(
                      widget.responseMessage,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

