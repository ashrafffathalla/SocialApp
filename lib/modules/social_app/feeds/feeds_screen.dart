import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/social_app/post_model.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
       return ConditionalBuilder(
        condition: SocialCubit.get(context).posts.length > 0 &&SocialCubit.get(context).userModel != null,
         builder: (context) => SingleChildScrollView(
           physics:const BouncingScrollPhysics(),
           scrollDirection: Axis.vertical,
           child: Column(
             children:[
               Card(
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 elevation: 5.0,
                 margin: EdgeInsets.all(8.0),
                 child: Stack(
                   alignment: AlignmentDirectional.bottomEnd,
                   children:[
                     const Image(
                       image: NetworkImage(
                         'https://image.freepik.com/free-photo/medium-shot-people-posing-with-baggage_23-2149243411.jpg',
                       ),
                       fit: BoxFit.cover,
                       height: 200.0,
                       width: double.infinity,
                     ),
                     Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text(
                         'communicate with friends',
                         style: Theme.of(context).textTheme.subtitle1!.copyWith(
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               ListView.separated(
                 physics:const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                 separatorBuilder: (context, index) => const SizedBox(
                   height: 8.0,
                 ),
                 itemCount: SocialCubit.get(context).posts.length,
               ),
               const SizedBox(height: 8.0,),
             ],
           ),
         ),
         fallback:(context) =>const Center(child: CircularProgressIndicator()),
       );
      },
    );
  }
  Widget buildPostItem(PostModel model, context, index) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:[
                        Text(
                          '${model.name}',
                          style:const TextStyle(
                            height: 1.4,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                onPressed: (){},
                icon:const Icon(
                  Icons.more_horiz,
                  size: 20.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 1.0,
            ),
          ),
          Text(
            '${model.text}',
            style:Theme.of(context).textTheme.subtitle1!.copyWith(
              height: 1.5,
              fontSize: 14.0,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children:
                [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#softwarw',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                          ),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end:6.0),
                    child: Container(
                      height: 25.0,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#softwarw',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                          ),
                        ),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(model.postImage != '')
          //Post image
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 160,
              width: double.infinity,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',

                    ),
                    fit: BoxFit.cover,

                  )
              ),
            ),
          ),
          //end Post image
          Padding(
            padding: const EdgeInsets.only(
              top:5,
              bottom: 3.0,
            ),
            child: Row(
              children:[
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 20.0,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,

                          ),
                        ],
                      ),
                    ),
                    onTap:(){} ,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            size: 20.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).comments[index]} comment',
                            style: Theme.of(context).textTheme.caption,

                          ),
                        ],
                      ),
                    ),
                    onTap:(){} ,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.grey[300],
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,

            ),
            child: InkWell(
              child: Row(
                children:[
                  Expanded(
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 17.0,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}'
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: ()
                          {
                            SocialCubit.get(context).commentPost(SocialCubit.get(context).postId[index]);
                          },
                          child: Text(
                            'write a comment...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),

                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,

                        ),
                      ],
                    ),
                    onTap:()
                    {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                    },
                  ),
                ],
              ),
              onTap: (){},
            ),
          ),

        ],
      ),
    ),
  );

}
