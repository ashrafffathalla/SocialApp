import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget
{
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar:AppBar(
            titleSpacing: 5.0,
            title:const Text(
              'Create Post',
            ),
            leading: IconButton(
              icon:const Icon(
                IconBroken.Arrow___Left_2,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: ()
                {
                  var now= DateTime.now();
                  if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                    );
                  }else
                    {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                },
                child:Text(
                  'Post'.toUpperCase(),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/full-shot-woman-posing-with-baggage_23-2149243405.jpg'
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Row(
                        children:
                        const[
                          Text(
                            'Ashraf Fathalla',
                            style:TextStyle(
                              height: 1.4,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration:const InputDecoration(
                      hintText: 'What is on your mind...',
                      border:InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(bottom: 11, top: 17, right: 15),

                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children:
                  [
                    Container(
                      height: 165.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image:FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon:const CircleAvatar(
                        radius: 15.0,
                        backgroundColor:Colors.grey,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child:Row(
                            children:const[
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(width: 5.0,),
                              Text('add photo',),
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                         child:const Text('# tags',),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
