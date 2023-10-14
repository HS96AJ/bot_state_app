import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bot_state_app/Assets/text_rows.dart';
import 'package:flutter/material.dart';

// Global Variables
const double containerPaddings = 20;
var limboColor = Colors.white12;

var limbo = false;
var _volume = 0.0;
var _liquid = 0.0;
var _withdrawable = 0.0;
var _todays = 0.0;
var _errors = 0;
var _warnings = 0;
var _badAPIs = 0;
var _totalTargets = 0;
var _totalOffers = 0;
var _badAPIsList = [];
var _withrawablePerAccount = {
  
};
const accountList = {
  "Account 00": "Dota",
  "Account 02": "Dota",
  "Account 10": "Dota",
  "Account 11": "Dota",
  "Account 12": "Dota",
  "Account 13": "Dota",
  "Account 03": "CSGO",
  "Account 04": "CSGO",
  "Account 05": "CSGO",
  "Account 14": "CSGO",
  "Account 08": "RUST",
  "Account 09": "RUST",
  "Account 15": "RUST",
  "Account 16": "RUST",
  "Account 17": "RUST",
  "Account 07": "TEAM",
};
const accountListForWithrawable =[
  "Account 00",
  "Account 02",
  "Account 10",
  "Account 11",
  "Account 12",
  "Account 13",
  "Account 03",
  "Account 04",
  "Account 05",
  "Account 14",
  "Account 08",
  "Account 09",
  "Account 15",
  "Account 16",
  "Account 17",
  "Account 07",
];

class BadAPIWidget extends StatelessWidget {
  
  final List badAPIsListGiven;
  final int numberOfBadAPIsGiven;
  const BadAPIWidget({required this.badAPIsListGiven,required this.numberOfBadAPIsGiven, super.key});

  @override
  Widget build(BuildContext context) {
    if (numberOfBadAPIsGiven == 0) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No Bad APIs",
              style: TextStyle(
                fontSize: 17,
              ))
        ],
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
          itemCount: badAPIsListGiven.length,
          itemBuilder: (context, index) {
            return TextRows(badAPIsListGiven[index],
                accountList[badAPIsListGiven[index]] ?? "No Account");
          });
    }
  }
}

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  Future<void> _refresh() async {
    try {
      final res = await http.get(Uri.parse("http://5.78.94.88:4000/"));
      final data = jsonDecode(res.body);
      setState(() {
        _volume = double.parse(data['reports']['Volume'].toStringAsFixed(2));
        _liquid = double.parse(data['reports']['Liquid'].toStringAsFixed(2));
        _withdrawable =
            double.parse(data['reports']['Withrawable'].toStringAsFixed(2));
        _todays = double.parse(data['reports']['Todays'].toStringAsFixed(2));
        _errors = data['reports']['Errors'];
        _warnings = data['reports']['Fails'];
        _badAPIs = data['reports']['BadAPICount'];
        _totalTargets = data['reports']['PerGame']["Dota"]["Comms"]["Targets"] +
            data['reports']['PerGame']["CSGO"]["Comms"]["Targets"] +
            data['reports']['PerGame']["RUST"]["Comms"]["Targets"] +
            data['reports']['PerGame']["TEAM"]["Comms"]["Targets"];
        _totalOffers = data['reports']['PerGame']["Dota"]["Comms"]["Offers"] +
            data['reports']['PerGame']["CSGO"]["Comms"]["Offers"] +
            data['reports']['PerGame']["RUST"]["Comms"]["Offers"] +
            data['reports']['PerGame']["TEAM"]["Comms"]["Offers"];
        limbo = data['reports']['Limbo'];
        if (_badAPIs != 0) {
          _badAPIsList = data['reports']['BadAPI'];
        }        

        for(var item in accountListForWithrawable)
        {
          if(data['reports']['Withrawable Per Account'].containsKey(accountList[item]))
          {
            if(data['reports']['Withrawable Per Account'][accountList[item]].containsKey(item))
            {
              _withrawablePerAccount[item] = data['reports']['Withrawable Per Account'][accountList[item]][item];
            }
          }
        }

        if (!limbo) {
          limboColor = Colors.white12;
        } else {
          limboColor = const Color.fromARGB(255, 114, 116, 0);
        }
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Colors.white,
        onRefresh: _refresh,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: containerPaddings,
                  left: containerPaddings,
                  right: containerPaddings),
              child: Container(
                decoration: BoxDecoration(
                    color: limboColor, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRows('Total Value', _volume.toString()),
                      TextRows('Total Liquid', _liquid.toString()),
                      TextRows('Withdrawable', _withdrawable.toString()),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: containerPaddings,
                  left: containerPaddings,
                  right: containerPaddings),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRows('Todays', _todays.toString()),
                      TextRows('Warnings', _warnings.toString()),
                      TextRows('Errors', _errors.toString()),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: containerPaddings,
                  left: containerPaddings,
                  right: containerPaddings),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRows('Total Offers', _totalOffers.toString()),
                      TextRows('Total Targets', _totalTargets.toString()),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: containerPaddings,
                  left: containerPaddings,
                  right: containerPaddings),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child:  BadAPIWidget(badAPIsListGiven: _badAPIsList,numberOfBadAPIsGiven: _badAPIs,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: containerPaddings,
                  left: containerPaddings,
                  right: containerPaddings),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: accountListForWithrawable.length,
                    itemBuilder: (context,index){
                     return TextRows(accountListForWithrawable[index],_withrawablePerAccount.containsKey(accountListForWithrawable[index])?_withrawablePerAccount[accountListForWithrawable[index]].toStringAsFixed(2):"No Data");
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ));
  }
}
