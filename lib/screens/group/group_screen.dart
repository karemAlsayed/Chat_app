


import 'package:chat_app/screens/group/widgets/group_member.dart';
import 'package:chat_app/screens/group/widgets/group_message_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

bool typing = false;

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name'),
            Text(
              'Ahmed,Mohamed,Abdelrahman',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupMemberScreen(),),);
            },
            icon: const Icon(Iconsax.people),
          ),
        
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Column(
          children: [
            Expanded(
              child:  ListView.builder(
                  reverse: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return 
                    
                  GroupMessageCard(index: index,);
                  }),
              // child: Center(
              //         child: GestureDetector(
              //           child: Card(
              //             color:  Theme.of(context).colorScheme.primaryContainer,
                          
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              //               child: Column(
              //                 mainAxisSize:  MainAxisSize.min,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text('👋',style: Theme.of(context).textTheme.displayMedium,),
              //                   const SizedBox(height: 16,),
              //                   Text('Say hi !',style: Theme.of(context).textTheme.bodyLarge,),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      onTapOutside: (event) {
                        setState(() {
                          typing = false;
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                      },
                      onTap: () {
                        setState(() {
                          typing = true;
                        });
                      },
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: typing
                            ? null
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Iconsax.gallery),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Iconsax.camera),
                                  ),
                                ],
                              ),
                        border: InputBorder.none,
                        hintText: 'Message',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Iconsax.send_1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
