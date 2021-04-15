import 'package:flutter/material.dart';
import 'package:todoList/util/app_localizations.dart';

class CommunityGuidelines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('communityGuidelines'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed vel lectus. Donec odio tempus molestie, porttitor ut, iaculis quis, sem. Sed convallis magna eu sem. Nullam eget nisl. Suspendisse nisl. Aenean vel massa quis mauris vehicula lacinia. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Aliquam ornare wisi eu metus. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Maecenas lorem. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Fusce nibh. In convallis. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. Fusce tellus. Maecenas libero. Vivamus porttitor turpis ac leo. Phasellus rhoncus. Fusce tellus. Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Etiam ligula pede, sagittis quis, interdum ultricies, scelerisque eu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean id metus id velit ullamcorper pulvinar. Etiam dictum tincidunt diam. Nullam dapibus fermentum ipsum. Vestibulum fermentum tortor id mi. Curabitur sagittis hendrerit ante.',
              softWrap: true,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}

class NotificationShow extends StatefulWidget {
  @override
  _NotificationShowState createState() => _NotificationShowState();
}

class _NotificationShowState extends State<NotificationShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('notification'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [Text('NOTIFICATION')],
      ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('privacyPolicy'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed vel lectus. Donec odio tempus molestie, porttitor ut, iaculis quis, sem. Sed convallis magna eu sem. Nullam eget nisl. Suspendisse nisl. Aenean vel massa quis mauris vehicula lacinia. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Aliquam ornare wisi eu metus. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Maecenas lorem. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Fusce nibh. In convallis. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. Fusce tellus. Maecenas libero. Vivamus porttitor turpis ac leo. Phasellus rhoncus. Fusce tellus. Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Etiam ligula pede, sagittis quis, interdum ultricies, scelerisque eu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean id metus id velit ullamcorper pulvinar. Etiam dictum tincidunt diam. Nullam dapibus fermentum ipsum. Vestibulum fermentum tortor id mi. Curabitur sagittis hendrerit ante.',
              softWrap: true,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}

class TermsOfService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('termsOfService'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed vel lectus. Donec odio tempus molestie, porttitor ut, iaculis quis, sem. Sed convallis magna eu sem. Nullam eget nisl. Suspendisse nisl. Aenean vel massa quis mauris vehicula lacinia. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Aliquam ornare wisi eu metus. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Maecenas lorem. Fusce dui leo, imperdiet in, aliquam sit amet, feugiat eu, orci. Fusce nibh. In convallis. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. Fusce tellus. Maecenas libero. Vivamus porttitor turpis ac leo. Phasellus rhoncus. Fusce tellus. Phasellus enim erat, vestibulum vel, aliquam a, posuere eu, velit. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Etiam ligula pede, sagittis quis, interdum ultricies, scelerisque eu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aenean id metus id velit ullamcorper pulvinar. Etiam dictum tincidunt diam. Nullam dapibus fermentum ipsum. Vestibulum fermentum tortor id mi. Curabitur sagittis hendrerit ante.',
              softWrap: true,
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
