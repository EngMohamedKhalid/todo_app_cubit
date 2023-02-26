import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomStatelessTextField extends StatelessWidget {
//   const CustomStatelessTextField(
//       {super.key,
//       required this.padding,
//       this.controller,
//       this.keyType,
//        this.prefix,
//        this.hintText,
//        this.onTap,
//       });
//   final String? hintText;
//   final EdgeInsetsGeometry padding;
//   final TextEditingController? controller;
//   final TextInputType? keyType;
//   final Widget? prefix;
//   final VoidCallback? onTap ;
//   @override
//   Widget build(BuildContext context) {
//     return
//       Container(
//       padding: padding,
//       child: TextFormField(
//         validator: (value) {
//           if(value!.isEmpty){
//             return "$hintText must not be empty";
//           }
//           return null;
//         },
//         keyboardType: keyType,
//         controller: controller,
//         style: const TextStyle(
//            color: Colors.white,
//             //fontWeight: FontWeight.bold,
//             fontSize: 20),
//         decoration: InputDecoration(
//           prefixIcon: prefix,
//           floatingLabelStyle: const TextStyle(color: Colors.white),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: const BorderSide(color: Colors.white)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: const BorderSide(color: Colors.white)),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           //label: Text(text!),
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             color: Colors.white
//           ),
//           labelStyle: const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             // fontWeight: FontWeight.bold
//           ),
//
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
//
// }

Widget customStatelessTextField({
  required EdgeInsetsGeometry padding,
  final String? hintText,
  final TextEditingController? controller,
  final TextInputType? keyType,
  final Widget? prefix,
  final VoidCallback? onTap
})=>Container(
  padding: padding,
  child: TextFormField(
    validator: (value) {
      if(value!.isEmpty){
        return "$hintText must not be empty";
      }
      return null;
    },
    keyboardType: keyType,
    controller: controller,
    style:  TextStyle(
        color: Colors.white,
        //fontWeight: FontWeight.bold,
        fontSize: 20.sp),
    decoration: InputDecoration(
      prefixIcon: prefix,
      floatingLabelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.sp),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.sp),
          borderSide: const BorderSide(color: Colors.white)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.sp),
      ),
      //label: Text(text!),
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Colors.white
      ),
      labelStyle:  TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        // fontWeight: FontWeight.bold
      ),

    ),
    onTap: onTap,
  ),
);
