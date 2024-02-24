import 'package:counter_tasbeeh/data_manager/data_manager.dart';

import 'tasbeeh_sizes_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tasbeeh_counter_provider.dart';
import '../../res/colors.dart';
import 'home_Page_constants.dart';

class Tasbeeh extends StatelessWidget {
  Tasbeeh({
    super.key,this.showUpdteButton,this.index,this.tasbeehName
  });

  bool? showUpdteButton=false;
  String? tasbeehName;
  int? index =-1;

  @override
  Widget build(BuildContext context) {
    final tasbeehCounterProvider = Provider.of<TasbeehCounterProvider>(context,listen: false);
    return Expanded(
      flex: 3,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * borderTopPadding),
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * borderTopMargin ),
            width: MediaQuery.of(context).size.width * tasbeehWidth,
            height: MediaQuery.of(context).size.height * tasbeehHeight,
            decoration: BoxDecoration(
                color: tasbeehBackgroundColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: MediaQuery.of(context).size.width * tasbeehBorderSize,color: tasbeehBorderColor,)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tasbeehName!=null ? tasbeehName! : "Tasbeeh",
                  style: tasbeehTextStyle(MediaQuery.of(context).size.height * tasbeehTextSize,
                      fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * counterMargin,
                      right: MediaQuery.of(context).size.width * counterMargin ),
                  width: MediaQuery.of(context).size.width * counterWidth,
                  height: MediaQuery.of(context).size.height * counterHeight,
                  decoration: BoxDecoration(
                      color: tasbeehCounterBoxColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: MediaQuery.of(context).size.width * counterBorderSize,color: tasbeehBorderColor,)
                  ),
                  child: Consumer<TasbeehCounterProvider>(
                    builder: (_,counterProvider,child){
                      return Text(
                        counterProvider.count.toString(),
                        textAlign: TextAlign.center,
                        style: tasbeehTextStyle(
                            MediaQuery.of(context).size.height * counterValueSize,
                            fontWeight: FontWeight.bold,
                            textColor: blackColor),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      if(showUpdteButton == null)
                        tasbeehButton(name: "Save", callback:  (){
                          showSaveDialog("Save Dhikr", "Dhikr Name", tasbeehCounterProvider.count, context);
                          tasbeehCounterProvider.resetCount();
                        }),
                      if(showUpdteButton != null)
                        tasbeehButton(name: "Update", callback:  (){
                          DataManager.updateData(index!, DataManager.keyValueList.elementAt(index!).keys.last, tasbeehCounterProvider.count , context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          tasbeehCounterProvider.resetCount();
                        }),
                      tasbeehButton(buttonSize: counterButtonSize,topMargin: counterButtonMargin,
                          callback:  (){
                            tasbeehCounterProvider.addCount();
                          }),
                      tasbeehButton(name: "Reset",callback:  (){tasbeehCounterProvider.resetCount();})
                    ],),
                ),


              ],
            ),
          ),
      ),

    );
  }
}

class tasbeehButton extends StatelessWidget {
  const tasbeehButton(
      {super.key,this.name,required this.callback,this.buttonSize,this.topMargin});
  final String? name;
  final VoidCallback callback;
  final double? buttonSize;
  final double? topMargin;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if(name!=null)
            Text(
              name!,
              style: tasbeehTextStyle(MediaQuery.of(context).size.height * buttonTextSize),
            ),
          if(topMargin!=null)
            SizedBox(height: MediaQuery.of(context).size.height * topMargin!,),
          GestureDetector(
            onTap: callback,
            child: Icon(
                  Icons.circle,
                  color: Colors.blue,
                  size: buttonSize== null?MediaQuery.of(context).size.height * tasbeehSmallButtons:MediaQuery.of(context).size.height * buttonSize!,
                ),
          )

          // IconButton(
          //     onPressed: (){},
          //     icon: Icon(
          //       Icons.circle,
          //       color: Colors.blue,
          //       size: MediaQuery.of(context).size.height * tasbeehSmallButtons,
          //     ))
        ],
      ),
    );
  }
}
