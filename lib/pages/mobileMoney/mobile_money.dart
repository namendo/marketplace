import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translations/translation.dart';
import '../../widgets/widgets.dart';
import '../NavigatorPages/walletpage.dart';
import '../loadingPage/loading.dart';
import '../noInternet/nointernet.dart';


class MobileMoney extends StatefulWidget {
  const MobileMoney({Key? key}) : super(key: key);

  @override
  State<MobileMoney> createState() => _MobileMoneyState();
}

dynamic otp;
dynamic nameProvider;
class _MobileMoneyState extends State<MobileMoney> {

  TextEditingController addOtpController = TextEditingController();
  bool _completed = false;
  bool _isLoading = true;
  bool showtoast = false;
  bool _isOtp = false;

  @override
  void initState() {
    otp='';
    nameProvider='';
    getProviderMobileMoney();
    super.initState();
  }

  getProviderMobileMoney() async {
    var val = await getProviderMM();
    if (val == 'success') {
      _isLoading = false;
      _completed = true;
      valueNotifierHome.incrementNotifier();
    } else{
      _isLoading = false;
      _completed = false;
      valueNotifierHome.incrementNotifier();
    }
  }

  showToast() {
    setState(() {
      showtoast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showtoast = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child){
            return Directionality(
                textDirection: (languageDirection == 'rtl')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Scaffold(
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(media.width * 0.05,
                            media.width * 0.05, media.width * 0.05, 0),
                        height: media.height * 1,
                        width: media.width * 1,
                        color: page,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).padding.top),
                            Stack(
                              children: [
                                Container(
                                  padding:
                                  EdgeInsets.only(bottom: media.width * 0.05),
                                  width: media.width * 1,
                                  alignment: Alignment.center,
                                  child: Text(
                                    languages[choosenLanguage]
                                    ['text_enable_Mobile_Money'],
                                    style: GoogleFonts.robotoCondensed(
                                        fontSize: media.width * twenty,
                                        fontWeight: FontWeight.w600,
                                        color: textColor),
                                  ),
                                ),
                                Positioned(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context,true);
                                        },
                                        child: const Icon(Icons.arrow_back)))
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            Expanded(child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: (providerMM.isNotEmpty)
                                  ? Column(
                                children: providerMM
                                    .asMap()
                                    .map((i, value) {
                                  return MapEntry(
                                      i,
                                      InkWell(
                                        onTap: () async {
                                          nameProvider=providerMM[i]
                                          ['name'];
                                          if (_isOtp == false) {
                                            if(providerMM[i]
                                            ['hasOtp']==true){setState(() {_isOtp = true;});}
                                            else{
                                              setState(() {
                                                _isLoading=true;
                                              });
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              var res = await mobileMoneyToWallet();
                                              if(res == 'success'){
                                                await Future.delayed(Duration(seconds: 3));
                                                setState(() {
                                                  showtoast = true;
                                                  _isOtp = false;
                                                  otp = '';
                                                  _isLoading=false;
                                                });
                                                Navigator.pop(context,true);
                                              }
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.02,
                                              bottom:
                                              media.width * 0.02),
                                          width: media.width * 0.9,
                                          padding: EdgeInsets.all(
                                              media.width * 0.025),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: borderLines,
                                                  width: 1.5),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(12),
                                              color: page),
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: media.width *
                                                      0.250,
                                                  width: media.width *
                                                      0.250,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10),
                                                      color: const Color(
                                                          0xff000000)
                                                          .withOpacity(
                                                          0.05)),
                                                  alignment:
                                                  Alignment.center,
                                                  child: Image.memory(convertImageProvider(providerMM[i]
                                                  ['logoImage']))
                                              ),
                                              SizedBox(
                                                width: media.width *
                                                    0.025,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                    media.width *
                                                        0.55,
                                                    child: Text(
                                                      providerMM[i]
                                                      ['name'],
                                                      style: GoogleFonts.robotoCondensed(
                                                          fontSize: media
                                                              .width *
                                                              twenty,
                                                          color:
                                                          textColor,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                })
                                    .values
                                    .toList(),
                              )
                                  : (_completed == true)
                                  ? Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Container(
                                    height: media.width * 0.7,
                                    width: media.width * 0.7,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/nodatafound.gif'),
                                            fit: BoxFit.contain)),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.02,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.9,
                                    child: Text(
                                      languages[choosenLanguage]
                                      ['text_noDataFound'],
                                      style: GoogleFonts.robotoCondensed(
                                          fontSize:
                                          media.width * sixteen,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: textColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              )
                                  : Container(),
                            ))
                          ],
                        ),
                      ),

                      //otp text
                      (_isOtp == true)
                          ? Positioned(
                          bottom: 0,
                          child: Container(
                            height: media.height * 1,
                            width: media.width * 1,
                            color: Colors.transparent.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: media.width * 0.05),
                                  width: media.width * 0.9,
                                  padding:
                                  EdgeInsets.all(media.width * 0.025),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: borderLines, width: 1.2),
                                      color: page),
                                  child: Column(children: [
                                    Container(
                                      height: media.width * 0.128,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                            color: borderLines, width: 1.2),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          Container(
                                            height: media.width * 0.128,
                                            width: media.width * 0.6,
                                            alignment: Alignment.center,
                                            child: TextField(
                                              controller: addOtpController,
                                              onChanged: (val) {
                                                setState(() {
                                                  otp = val;
                                                });
                                              },
                                              keyboardType:
                                              TextInputType.number,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                languages[choosenLanguage]
                                                ['text_enable_OTP'],
                                                hintStyle: GoogleFonts.robotoCondensed(
                                                    fontSize:
                                                    media.width * twelve,
                                                    color: hintColor),
                                              ),
                                              maxLines: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Button(
                                          onTap: () async {
                                            setState(() {
                                              _isOtp = false;
                                              otp = '';
                                              FocusManager
                                                  .instance.primaryFocus
                                                  ?.unfocus();
                                              addOtpController.clear();
                                            });
                                          },
                                          text: languages[choosenLanguage]
                                          ['text_cancel'],
                                          width: media.width * 0.4,
                                        ),
                                        Button(
                                          onTap: () async {
                                            setState(() {
                                              _isLoading=true;
                                            });
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            var res = await mobileMoneyToWallet();
                                            if(res == 'success'){
                                              await Future.delayed(Duration(seconds: 3));
                                              setState(() {
                                                showtoast = true;
                                                _isOtp = false;
                                                otp = '';
                                                _isLoading=false;
                                              });
                                              Navigator.pop(context,true);
                                            }
                                          },
                                          text: languages[choosenLanguage]
                                          ['text_ok'],
                                          width: media.width * 0.4,
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ))
                          : Container(),
                      //no internet
                      (internet == false)
                          ? Positioned(
                          top: 0,
                          child: NoInternet(
                            onTap: () {
                              setState(() {
                                internetTrue();
                                _completed = false;
                                _isLoading = true;
                                //getWallet();
                              });
                            },
                          ))
                          : Container(),

                      //loader
                      (_isLoading == true)
                          ? const Positioned(child: Loading())
                          : Container(),

                      (showtoast == true)
                          ? Positioned(
                          bottom: media.height * 0.2,
                          left: media.width * 0.2,
                          right: media.width * 0.2,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(media.width * 0.025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent.withOpacity(0.6)),
                            child: Text(
                              languages[choosenLanguage]
                              ['text_mobile_money_successfully'],
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: media.width * twelve,
                                  color: Colors.white),
                            ),
                          ))
                          : Container()
                    ],
                  ),
                ));
    }),
    );
  }
}
