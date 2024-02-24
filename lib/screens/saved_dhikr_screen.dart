
import 'package:counter_tasbeeh/constants/home_page/home_Page_constants.dart';
import 'package:counter_tasbeeh/data_manager/data_manager.dart';
import 'package:counter_tasbeeh/screens/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tasbeeh_counter_provider.dart';

class SavedDhikrsScreen extends StatefulWidget {
  const SavedDhikrsScreen({super.key});

  @override
  State<SavedDhikrsScreen> createState() => _SavedDhikrsScreenState();
}

class _SavedDhikrsScreenState extends State<SavedDhikrsScreen> {
  List<Map<String, int>> keyValueList=[];
  bool showLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataManager.loadData();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      keyValueList = DataManager.keyValueList;
      showLoading = false;
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Saved Dhikr"),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back),),
      ),
      body: showLoading ? const Center(
        child: CircularProgressIndicator(),
      ):Container(
        child:keyValueList.isEmpty ? const Center(child: Text("No Saved Dhikr Available"),):
        ListView.builder(
          itemCount:keyValueList.length ,
          itemBuilder: (_,index){
            return ListTile(
              leading: SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Text(keyValueList[index].keys.toString(),style: tasbeehTextStyle(25,fontWeight: FontWeight.bold,textColor: Colors.black),overflow: TextOverflow.ellipsis)),
              trailing:Text(keyValueList[index].values.toString(),style: tasbeehTextStyle(25,fontWeight: FontWeight.bold,textColor: Colors.black),overflow: TextOverflow.ellipsis),
              // contentPadding: EdgeInsets.all(15),
              tileColor: Colors.black12,
              onTap: (){
                final tasbeehCounterProvider = Provider.of<TasbeehCounterProvider>(context,listen: false);
                tasbeehCounterProvider.setCount(keyValueList.elementAt(index).values.last);
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return HomePage(index: index,showUpdteButton: true,tasbeehName:keyValueList.elementAt(index).keys.last , );
                }));
              },
              onLongPress: ()async{
                bool isDeleted =await showRemoveDialog("Remove Dikhr", index, context);
                if(isDeleted)
                {
                  setState(() {
                    keyValueList = DataManager.keyValueList;
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}


//
// FutureBuilder(
// future: keyValueList,
// builder: (_,AsyncSnapshot<List<Map<String, int>>?> snapshot){
// if(snapshot.connectionState==ConnectionState.waiting)
// {
// return Center(child: CircularProgressIndicator(),);
// }else if(snapshot.data==null)
// {
// return Center(child: Text("No Dhikr Saved"),);
// }
// else{
// return Center(child: Text(snapshot.data!.first.toString()),);
// }
// })