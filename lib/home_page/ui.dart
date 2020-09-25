import 'package:atm/general/adapt.dart';
import 'package:atm/general/behavior.dart';
import 'package:atm/general/color.dart';
import 'package:atm/general/sum_input_format.dart';
import 'package:atm/general/textstyle.dart';
import 'package:atm/home_page/bloc.dart';
import 'package:atm/home_page/event.dart';
import 'package:atm/home_page/model/result.dart';
import 'package:atm/home_page/widgets/wave1.dart';
import 'package:atm/home_page/widgets/wave2.dart';
import 'package:atm/home_page/widgets/wave4.dart';
import 'package:atm/home_page/widgets/wave5.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _limits = ['100', '200', '500', '1000', '2000', '5000'];
  final TextEditingController _controller = TextEditingController();
  final HomePageBloc _bloc = HomePageBloc();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _bloc.dispose();
  }

  Widget _divider(){
    return Container(
      height: Adapt.px(10.0),
      color: AppColor.blue.withOpacity(0.05),
    );
  }

  Widget _gradientContainer(double height, bool rotate){
    return Container(
      height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: rotate ? [0, 0.5] : [0.5, 1.0],
            colors: [
              rotate ? AppColor.violet.withOpacity(0.7) : AppColor.blue.withOpacity(0.7),
              rotate ? AppColor.blue.withOpacity(0.8) : AppColor.violet.withOpacity(0.7),
            ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Builder(
      builder: (context){
        Adapt.initContext(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            child: SizedBox(
              height: Adapt.px(100.0),
              child: Material(
                color: Colors.transparent,
                elevation: 6,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.5, 1.0],
                      colors: [AppColor.blue.withOpacity(0.9), AppColor.violet.withOpacity(0.9)],
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: Adapt.px(16.0)),
                        Image(
                          image: AssetImage('assets/logo.png'),
                          height: Adapt.px(26.0),
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: Adapt.px(5.0)),
                        Text(
                          'ATM',
                          style: AppTextStyle.logo,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(Adapt.px(60.0)),
          ),
          body: ScrollConfiguration(
            behavior: Behavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: Stack(
                          children: [
                            CustomPaint(painter: Wave5(true), size: Size(double.infinity, Adapt.px(180.0))),
                            CustomPaint(painter: Wave4(true), size: Size(double.infinity, Adapt.px(180.0))),
                            CustomPaint(painter: Wave1(true), size: Size(double.infinity, Adapt.px(180.0))),
                            ClipPath(clipper: Wave2(true), child: _gradientContainer(Adapt.px(180.0), true)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Adapt.px(20.0)),
                          Text(
                            'Введите сумму',
                            style: AppTextStyle.textWhite,
                            textAlign: TextAlign.center,
                          ),
                          Center(
                            child: SizedBox(
                              width: Adapt.px(180.0),
                              child: TextField(
                                controller: _controller,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  SumInputFormatter()
                                ],
                                scrollPadding: EdgeInsets.zero,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: AppTextStyle.input,
                                cursorColor: AppColor.violet,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: Adapt.px(1.0))),
                                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: Adapt.px(1.0))),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: Adapt.px(15.0)),
                  Center(
                    child: InkWell(
                      onTap: (){
                        if(_controller.text.isEmpty) return;
                        _bloc.event.add(GetMoneyEvent(int.tryParse(_controller.text.substring(0, _controller.text.length-4)) ?? 0));
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                      },
                      splashColor: AppColor.violet,
                      highlightColor: AppColor.violet,
                      borderRadius: BorderRadius.circular(Adapt.px(50.0)),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(50.0)),
                          color: AppColor.pink
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Adapt.px(46.0), vertical: Adapt.px(22.0)),
                          child: Text(
                            'Выдать сумму',
                            style: AppTextStyle.textWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Adapt.px(22.0)),
                  _divider(),
                  StreamBuilder(
                      stream: _bloc.stream,
                      builder: (context, AsyncSnapshot<Result> result){
                        return Column(
                          children: [
                            SizedBox(
                              height: Adapt.px(128.0),
                              child: Center(
                                 child: result.hasData && result.data.give != null
                                   ? result.data.give.isNotEmpty
                                      ? Column(
                                         crossAxisAlignment: CrossAxisAlignment.stretch,
                                         children: [
                                           Padding(
                                             padding: EdgeInsets.only(top: Adapt.px(20.0), bottom: Adapt.px(17.0), left: Adapt.px(21.0)),
                                             child: Text(
                                               'Банкомат выдал следующие купюры',
                                               style: AppTextStyle.textGrey,
                                             ),
                                           ),
                                           Wrap(
                                             children: List.generate(6, (index){
                                               if(result.data.give[index] > 0) return SizedBox(
                                                 width: size.width/2-2,
                                                 child: Text(
                                                   '${result.data.give[index]} x ${_limits[index]} рублей',
                                                   style: AppTextStyle.textBlue,
                                                   textAlign: TextAlign.center,
                                                 ),
                                               );
                                               return SizedBox(width: 0);
                                             }),
                                           )
                                         ],
                                       )
                                     : Text(
                                          'Банкомат не может выдать,\nзапрашиваемую сумму',
                                          style: AppTextStyle.notAllow,
                                          textAlign: TextAlign.center,
                                      )
                                   : Container(),
                              ),
                            ),
                            _divider(),
                            SizedBox(
                              height: Adapt.px(128.0),
                              child: Center(
                                child: result.hasData
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: Adapt.px(20.0), bottom: Adapt.px(17.0), left: Adapt.px(21.0)),
                                          child: Text(
                                            'Баланс банкомата',
                                            style: AppTextStyle.textGrey,
                                          ),
                                        ),
                                        Wrap(
                                          children: List.generate(6, (index){
                                            return SizedBox(
                                              width: size.width/2,
                                              child: Text(
                                                '${result.data.balance[index]} x ${_limits[index]} рублей',
                                                style: AppTextStyle.textBlue,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                        )
                                      ],
                                    )
                                  : Container(),
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                  _divider(),
                  SizedBox(height: Adapt.px(26.0)),
                  Stack(
                    children: [
                      CustomPaint(painter: Wave5(false), size: Size(double.infinity, Adapt.px(132.0))),
                      CustomPaint(painter: Wave4(false), size: Size(double.infinity, Adapt.px(132.0))),
                      CustomPaint(painter: Wave1(false), size: Size(double.infinity, Adapt.px(132.0))),
                      ClipPath(clipper: Wave2(false), child: _gradientContainer(Adapt.px(132.0), false)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}