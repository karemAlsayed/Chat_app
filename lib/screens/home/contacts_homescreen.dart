




import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactsHomeScreen extends StatefulWidget {
  const ContactsHomeScreen({super.key});

  @override
  State<ContactsHomeScreen> createState() => _ContactsHomeScreenState();
}

class _ContactsHomeScreenState extends State<ContactsHomeScreen> {
  bool searched = false;
  TextEditingController controller = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Enter Contact Email :', style: Theme.of(context).textTheme.bodyLarge),

                        const Spacer(),
                        IconButton(onPressed: () {}, icon: const Icon(Iconsax.scan_barcode))

                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        label: 'Email',
                        prefixIcon: Iconsax.user,
                        controller: controller,
                        obscureText: false,
                        isPassword: false),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      
                      onPressed: () {},
                      style:  ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Theme .of(context).colorScheme.primaryContainer
                      ), 
                      child: 
                      const Center(child: Text('Create Group', style: TextStyle(color: Colors.white),)),
                      ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.user_add),
      ),
      appBar: AppBar(
        actions:searched?[
          IconButton(onPressed: () {
            setState(() {
              searched = !searched;
            });
          }, icon: const Icon(Iconsax.close_circle)),
        ]: [
          IconButton(onPressed: () {
            setState(() {
              searched = !searched;
            });
          }, icon: const Icon(Iconsax.search_normal)),
        ],
        title: searched? Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  )
                ),

              )
            )
          ],
        ) : const Text('contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: 
                (context, index) {
                  return const ContactCard();
                },
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Name'),
        // subtitle: const Text('Name'),
        // leading: const CircleAvatar(),
        trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.message)),
      ),
    );
  }
}