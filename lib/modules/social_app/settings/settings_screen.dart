import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/edit_profile/edit_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

class SocialSettingsScreen extends StatelessWidget {
  const SocialSettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {
      },
      builder: (context, state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 215,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children:
                  [
                    Align(
                      child: Container(
                        height: 165.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:const BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${userModel!.cover}',),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        backgroundImage:NetworkImage(
                          '${userModel.image}',
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${userModel.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(width: 3,),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 16,

                  ),
                ],
              ),
              Text('${userModel.bio}',style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Post',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '265',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '20k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '200',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: (){},
                      child:const Icon(
                        IconBroken.More_Square,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: const Text(
                        'Add Photos'
                      ),

                    ),
                  ),
                   Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        navigateTo(
                            context,
                          EditProfileScreen(),
                        );
                      },
                      child:const Icon(
                        IconBroken.Edit_Square,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children:
                [
                  OutlinedButton(
                    onPressed: ()
                    {
                      FirebaseMessaging.instance.subscribeToTopic('announcements');
                    },
                    child:const Text('subscribe'),
                  ),
                  Spacer(),
                  OutlinedButton(
                    onPressed: ()
                    {
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                    },
                    child:const Text('unsubscribe'),
                  ),
                ],
              ),


            ],
          ),
        );
      },
    );
  }
}
