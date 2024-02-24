import 'package:counter_tasbeeh/data_manager/data_manager.dart';
import 'package:counter_tasbeeh/res/colors.dart';
import 'package:flutter/material.dart';

TextStyle tasbeehTextStyle(double size,{FontWeight? fontWeight,FontStyle? fontStyle,Color? textColor})
{
  TextStyle style =TextStyle(
      color: textColor ?? tasbeehTextColor,
      fontSize: size,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: fontWeight?? FontWeight.normal,

  );
  return style;
}

void showSaveDialog(String dialogTitle,String lable,int value,BuildContext context )
{
  TextEditingController textController = TextEditingController();
  showDialog(context: context, builder: (_){
    return AlertDialog(
      title: Text(dialogTitle),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(
            label: Text(lable)
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){
          DataManager.saveNewData(textController.text,value, context);
          Navigator.pop(context);
        }, child: const Text("Save")),
      ],
    );
  });
}

Future<bool> showRemoveDialog(String dialogTitle,int index,BuildContext context )async
{
  bool isDeleted=false ;
  await showDialog(context: context, builder: (_){
    return AlertDialog(
      title: Text(dialogTitle),
      content: ListTile(
        leading: Text(DataManager.keyValueList.elementAt(index).keys.toString()),
        trailing: Text(DataManager.keyValueList.elementAt(index).values.toString()),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          isDeleted =false;
        }, child: const Text("Cancel")),
        TextButton(onPressed: (){
          DataManager.removeData(index);
          isDeleted = true;
          Navigator.pop(context);
        }, child: const Text("Yes")),
      ],
    );
  });
  return isDeleted;
}