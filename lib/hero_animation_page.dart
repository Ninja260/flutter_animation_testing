import 'package:flutter/material.dart';

class HeroAnimationPage extends StatelessWidget {
  const HeroAnimationPage({super.key});

  static const String route = '/hero-animation-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'People',
        ),
      ),
      body: ListView.builder(
        itemCount: personList.length,
        itemBuilder: (context, index) {
          final person = personList[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    person: person,
                  ),
                ),
              );
            },
            leading: Hero(
              tag: person.name,
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    return ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(
                          begin: 0,
                          end: 1,
                        ).chain(
                          CurveTween(
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: toHeroContext.widget,
                      ),
                    );
                  case HeroFlightDirection.pop:
                    return Material(
                      color: Colors.transparent,
                      child: fromHeroContext.widget,
                    );
                }
              },
              child: Text(
                person.emoji,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            title: Text(person.name),
            subtitle: Text(
              '${person.age} years old',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.person,
  });

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          //flightShuttleBuilder: (flightContext, animation, flightDirection,
          ////    fromHeroContext, toHeroContext) {
          //  switch (flightDirection) {
          //    case HeroFlightDirection.push:
          //      return Material(
          //        color: Colors.transparent,
          //        child: ScaleTransition(
          //          scale: animation.drive(
          //            Tween<double>(
          //              begin: 0,
          //              end: 1,
          //            ).chain(
          //              CurveTween(
          //                curve: Curves.fastOutSlowIn,
          //              ),
          //            ),
          //          ),
          //          child: toHeroContext.widget,
          //        ),
          //      );
          //    case HeroFlightDirection.pop:
          //      return Material(
          //        color: Colors.transparent,
          //        child: fromHeroContext.widget,
          //      );
          //  }
          //},
          tag: person.name,
          child: Text(
            person.emoji,
            style: const TextStyle(
              fontSize: 50,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${person.age} years old',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class Person {
  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });

  final String name;
  final String age;
  final String emoji;
}

const List<Person> personList = [
  Person(
    name: 'Myo Min Hein',
    age: '28',
    emoji: '🙋🏽‍♂️',
  ),
  Person(
    name: 'Myo Myo Myat',
    age: '29',
    emoji: '🙋🏻‍♀️',
  ),
  Person(
    name: 'David',
    age: '30',
    emoji: '🙋🏼',
  ),
];
