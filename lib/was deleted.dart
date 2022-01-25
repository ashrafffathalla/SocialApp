import 'package:flutter/material.dart';

class Deleted extends StatelessWidget {
  const Deleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //الجزء الخاص ب verification
    // var model = SocialCubit.get(context).model;
    // return Column(
    //   children: [
    //     if(!FirebaseAuth.instance.currentUser!.emailVerified)
    //       Container(
    //         color: Colors.amber.withOpacity(.6),
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 20.0,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children:[
    //               const Icon(
    //                 Icons.info_outline,
    //               ),
    //               const SizedBox(
    //                 width: 15.0,
    //               ),
    //               const  Expanded(
    //                 child: Text(
    //                   'Pleas Verify your email',
    //                 ),
    //               ),
    //               TextButton(
    //                 onPressed:()
    //                 {
    //                   FirebaseAuth.instance.currentUser!
    //                       .sendEmailVerification()
    //                       .then((value){
    //                     showToast(
    //                       text: 'Check Your Email',
    //                       state: ToastStates.SUCCESS,);
    //                   })
    //                       .catchError((error){
    //
    //                   });
    //                 },
    //                 child: const Text(
    //                   'send',
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //   ],
    // );
    );
  }
}
