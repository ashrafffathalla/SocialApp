import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/social_app/chat_details/chat_details.screen.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).allUsers.isNotEmpty,
          builder: (context) => ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).allUsers[index],context),
            separatorBuilder: (context, index) =>const Divider(),
            itemCount: SocialCubit.get(context).allUsers.length,
          ),
          fallback: (context) =>Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: ()
    {
      navigateTo(
          context,
          ChatDetailsScreen(
              userModel: model,
          ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style:const TextStyle(
              height: 1.4,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    ),
  );
}
