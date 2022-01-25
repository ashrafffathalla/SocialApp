import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/social_app/message_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/models/user/user.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';
class ChatDetailsScreen extends StatelessWidget
{
  SocialUserModel userModel;
  ChatDetailsScreen({Key? key,
    required this.userModel
}) : super(key: key);

 var messageController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Builder(
      builder: (context)
      {
        SocialCubit.get(context).getMessage(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index)
                            {

                              var message = SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel!.uId == message.senderId)

                                return buildMyMessage(message);
                                return buildMessage(message);
                              },

                              //if(SocialCubit.get(context).userModel!.uId == message.senderId)
                               // {
                                  //return buildMyMessage(message);
                                //}


                            separatorBuilder: (context, index) =>const SizedBox(height:15 ,),
                            itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color:const Color(0xFFE0E0E0),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children:
                          [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration:const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: MaterialButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child:const Icon(
                                  IconBroken.Send,
                                  size: 18.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
  Widget buildMessage(MessageModel model) =>Align(
    alignment: AlignmentDirectional.topStart,
    child: Container(
      decoration:BoxDecoration(
        color: Colors.grey[300],
        borderRadius:const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
      ),
      padding:const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0
      ),
      child: Text(
        '${model.text}',
      ),
    ),
  );
  Widget buildMyMessage(MessageModel model) =>Align(
    alignment: AlignmentDirectional.topEnd,
    child: Container(
      decoration:BoxDecoration(
        color: defaultColor.withOpacity(0.2),
        borderRadius:const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
      ),
      padding:const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0
      ),
      child: Text(
        '${model.text}',
      ),
    ),
  );
}
