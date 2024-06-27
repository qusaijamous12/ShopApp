import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic NavigateAndFinish(context,Widget widget)=>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);

Widget TextDefaultButton(
    String text,
    void Function()? onPress
    )=>TextButton(
    onPressed:onPress,
    child: Text(
      '${text}',
      style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize:18
      ),

    ));


Widget BuildDefaultTextFormField({
  required String ?Text,
  required IconData ?prefixIcon,
  IconData ?suffixIxon,
  required bool ObsecureText,
  required TextInputType textInputType,
  required TextEditingController controller,
  required  String ? Function(String?)? validate,
  void Function()? onpressIconButton,
  void Function(String?)? onchange

})=> TextFormField(
  decoration: InputDecoration(
    labelText: '${Text}',
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefixIcon
    ),
    suffixIcon: IconButton(
      onPressed: onpressIconButton,
      icon: Icon(
        suffixIxon
      ),

    ),

  ),
  keyboardType:textInputType,
  controller:controller ,
  obscureText: ObsecureText,
  validator:validate,
  onChanged:onchange ,


);
Widget BuildDefaultButton({
  required void Function()? onpress,
  required String text,
  required Color color
})=>Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
  ),
  child:   MaterialButton(
      onPressed: onpress,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),


    ),
  ),
);

dynamic token='';
