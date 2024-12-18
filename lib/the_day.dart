import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/maya_images.dart';
import '../maya_cross_container.dart';
import '../methods/get_haab_date.dart';
import '../methods/get_kin_number.dart';
import '../methods/update_list.dart';
import '../providers/dayitems.dart';
import '../selection_dialog.dart';

class TheDay extends StatefulWidget {
  final ImageProvider backgroundImage;
  final Color mainColor;
  final int chosenYear;
  final int chosenDay;
  final int chosenTone;
  final int chosenNahual;
  final int beginTone;
  final int beginNahual;
  final List<int> chosenLongCount;
  final DateTime chosenGregorianDate;
  const TheDay(
      {super.key,
      required this.backgroundImage,
      required this.mainColor,
      required this.chosenYear,
      required this.chosenDay,
      required this.chosenTone,
      required this.chosenNahual,
      required this.beginTone,
      required this.beginNahual,
      required this.chosenLongCount,
      required this.chosenGregorianDate});

  @override
  State<TheDay> createState() => _TheDayState();
}

class _TheDayState extends State<TheDay> {
  late DateFormat dateFormat;

  late BoxDecoration boxDecoration;
  late BoxDecoration addIconDecoration;

  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16);

  late Image imageTone;
  late Image imageNahual;

  late int chosenKinIndex;

  late int longCount;

  late int baktun;
  late int katun;
  late int tun;
  late int winal;
  late int kin;

  late int cYear;
  int dYear = 0;
  final int itemCountHalf = 20;
  late final PageController _pageController;

  @override
  void initState() {
    initializeDateFormatting();
    String languageCode = Get.locale.toString();
    dateFormat = DateFormat("E dd.MM.yyyy", languageCode);
    chosenKinIndex = getKinNumber(widget.chosenTone, widget.chosenNahual);
    longCount = widget.chosenLongCount[0] * 144000 +
        widget.chosenLongCount[1] * 7200 +
        widget.chosenLongCount[2] * 360 +
        widget.chosenLongCount[3] * 20 +
        widget.chosenLongCount[4];

    cYear = widget.chosenYear;
    _pageController = PageController(initialPage: itemCountHalf);

    boxDecoration = BoxDecoration(
        color: widget.mainColor.withOpacity(0.5),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle);

    addIconDecoration = BoxDecoration(
        color: widget.mainColor.withOpacity(0.5),
        border: Border.all(color: Colors.white, width: 1),
        shape: BoxShape.circle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(children: [
          PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  cYear = (widget.chosenYear * 365 +
                          widget.chosenDay +
                          value -
                          20) ~/
                      365;
                  dYear = cYear - widget.chosenYear;
                });
              },
              controller: _pageController,
              itemCount: itemCountHalf * 2 + 1,
              reverse: false,
              itemBuilder: (context, position) {
                final haabDate = getHaabDate(
                    (widget.chosenDay + position - itemCountHalf) % 365);
                final dDays = position - itemCountHalf;

                baktun = (longCount + dDays) ~/ 144000 % 14;
                katun = (longCount - baktun * 144000 + dDays) ~/ 7200 % 20;
                tun = (longCount - baktun * 144000 - katun * 7200 + dDays) ~/
                    360 %
                    20;
                winal = (longCount -
                        baktun * 144000 -
                        katun * 7200 -
                        tun * 360 +
                        dDays) ~/
                    20 %
                    18;
                kin = (longCount -
                        baktun * 144000 -
                        katun * 7200 -
                        tun * 360 -
                        winal * 20 +
                        dDays) %
                    20;

                return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: widget.backgroundImage, fit: BoxFit.cover)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            10, statusBarHeight + 10, 10, 0),
                        child: SizedBox(
                            height: 160,
                            child: Column(children: [
                              Row(children: [
                                GestureDetector(
                                    onTap: () {
                                      showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Align(
                                                alignment:
                                                    const Alignment(0, 0.4),
                                                child: mayaCrossContainer(
                                                    size,
                                                    widget.backgroundImage,
                                                    widget.mainColor,
                                                    (widget.chosenTone +
                                                            dDays) %
                                                        13,
                                                    (widget.chosenNahual +
                                                            dDays) %
                                                        20));
                                          });
                                    },
                                    child: Container(
                                        height: 150,
                                        width: 120,
                                        decoration: boxDecoration,
                                        child: Column(children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.833, bottom: 4),
                                              child: SizedBox(
                                                  height: 37,
                                                  width: 80,
                                                  child: MayaImages()
                                                          .imageToneWhiteCurvedBottom[
                                                      (widget.chosenTone +
                                                              dDays) %
                                                          13])),
                                          SizedBox(
                                              height: 93.333,
                                              width: 100,
                                              child: MayaImages().signNahual[
                                                  (widget.chosenNahual +
                                                          dDays) %
                                                      20])
                                        ]))),
                                SizedBox(
                                  width: size.width - 140,
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                              height: 58,
                                              width: 58,
                                              child: MayaImages().signNahual[
                                                  (((chosenKinIndex + dDays) ~/
                                                              13) %
                                                          20) *
                                                      13 %
                                                      20]),
                                          Container(
                                              height: 40,
                                              width: size.width * 0.26,
                                              decoration: boxDecoration,
                                              child: Center(
                                                  child: Text(
                                                '${haabDate[0].toString().padLeft(2, '0')}.${(haabDate[1] + 1).toString().padLeft(2, '0')}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ))),
                                          SizedBox(
                                              width: 48,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 42,
                                                        child: MayaImages()
                                                                .imageToneWhiteCurved[
                                                            (widget.beginTone +
                                                                    dYear *
                                                                        365) %
                                                                13]),
                                                    const SizedBox(height: 2),
                                                    MayaImages().signNahual[
                                                        (widget.beginNahual +
                                                                dYear * 365) %
                                                            20]
                                                  ]))
                                        ]),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                      child: Container(
                                          height: 30,
                                          width: size.width * 0.34,
                                          decoration: boxDecoration,
                                          child: Center(
                                              child: Text(
                                            '$baktun.$katun.$tun.$winal.$kin',
                                            style: textStyle,
                                          ))),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              height: 30,
                                              width: size.width * 0.40,
                                              decoration: boxDecoration,
                                              child: Center(
                                                  child: Text(
                                                      dateFormat.format(widget
                                                          .chosenGregorianDate
                                                          .add(Duration(
                                                              days: dDays))),
                                                      style: textStyle))),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              decoration: addIconDecoration,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return selectionDialog(
                                                              context,
                                                              widget.mainColor,
                                                              widget.chosenYear +
                                                                  (position -
                                                                          itemCountHalf) ~/
                                                                      365,
                                                              (widget.chosenDay +
                                                                      position -
                                                                      itemCountHalf) %
                                                                  365,
                                                              widget
                                                                  .chosenGregorianDate
                                                                  .add(Duration(
                                                                      days:
                                                                          dDays)));
                                                        });
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: SvgPicture.asset(
                                                          'assets/vector/add_icon.svg'))))
                                        ])
                                  ]),
                                )
                              ]),
                              const Divider(
                                  color: Colors.white,
                                  height: 25,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0),
                              Consumer<DayItems>(
                                  builder: (context, data, child) {
                                int cYear = (widget.chosenYear * 365 +
                                        widget.chosenDay +
                                        dDays) ~/
                                    365;
                                int cDay = (widget.chosenDay + dDays) % 365;
                                if (data.dayItems.containsKey(cYear)) {
                                  if (data.dayItems[cYear].containsKey(cDay)) {
                                    return SizedBox(
                                        height: size.height -
                                            160 -
                                            statusBarHeight -
                                            25,
                                        child: ReorderableListView(
                                            shrinkWrap: true,
                                            children: data.dayItems[cYear]
                                                [cDay],
                                            onReorder:
                                                (int oldIndex, int newIndex) {
                                              setState(() {
                                                updateList(oldIndex, newIndex,
                                                    cYear, cDay);
                                              });
                                            }));
                                  } else {
                                    //TODO: maybe change
                                    return const SizedBox();
                                  }
                                } else {
                                  //TODO: maybe change
                                  return const SizedBox();
                                }
                              })
                            ]))));
              }),
          Positioned(
              left: size.width * 0.5 - size.width * 0.16,
              top: statusBarHeight,
              child: ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                      height: size.width * 0.08,
                      width: size.width * 0.32,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(200, 46, 125, 50),
                      ),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('${cYear + 12}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.05)))))),
          Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                  clipper: OvalTopBorderClipper(),
                  child: Container(
                      height: 37,
                      width: size.width * 0.304,
                      decoration: const BoxDecoration(color: Colors.white)))),
          Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(20);
                  },
                  child: ClipPath(
                      clipper: OvalTopBorderClipper(),
                      child: Container(
                          height: 36,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                              color: Color.lerp(
                                  widget.mainColor, Colors.black, 0.2)!),
                          child: const Align(
                              alignment: Alignment.center,
                              child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(Icons.unfold_less,
                                      color: Colors.white, size: 30)))))))
        ])));
  }
}
