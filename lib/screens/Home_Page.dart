
import 'package:counter_tasbeeh/constants/home_page/home_Page_constants.dart';
import 'package:counter_tasbeeh/data_manager/data_manager.dart';
import 'package:counter_tasbeeh/res/colors.dart';
import 'package:counter_tasbeeh/screens/saved_dhikr_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/home_page/tasbeeh.dart';
import '../provider/tasbeeh_counter_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key,this.showUpdteButton,this.index,this.tasbeehName });

  bool? showUpdteButton=false;
  int? index =-1;
  String? tasbeehName;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int colorIndex = 0;

  void goSavedDhikrScreen(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (_)=>const SavedDhikrsScreen()));
  }
  void changeColor()
  {
    colorIndex++;
    if(colorIndex >= backgroundColors.length)
      {
        colorIndex = 0;
      }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Tasbeeh Counter",style: tasbeehTextStyle(
          MediaQuery.of(context).size.height*0.025,fontWeight: FontWeight.bold,textColor: Colors.white
        ),),
        actions: [
          TextButton(onPressed: (){
            if(widget.showUpdteButton==null)
              {
                goSavedDhikrScreen(context);
                return;
              }
            final tasbeehCounterProvider = Provider.of<TasbeehCounterProvider>(context,listen: false);
            DataManager.updateData(widget.index!, DataManager.keyValueList.elementAt(widget.index!).keys.last, tasbeehCounterProvider.count , context);
            Navigator.pop(context);
          }, child: const Text("Saved Diker",style: TextStyle(

            fontWeight: FontWeight.bold,
            color:Colors.black
          ),))
        ],
      ),
      body: Container(
        color: backgroundColors[colorIndex],
        child: Column(
          children: [
            Expanded(

                child: Image.asset("assets/images/tasbeeh.png",color: tasbeehColor,fit: BoxFit.fill,)),
            if(widget.showUpdteButton==null)
              Tasbeeh(),
            if(widget.showUpdteButton!=null)
              Tasbeeh(showUpdteButton: widget.showUpdteButton,index: widget.index,tasbeehName: widget.tasbeehName,),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          changeColor();
        },
        child: const Icon(Icons.color_lens_outlined),),
    );
  }
}


