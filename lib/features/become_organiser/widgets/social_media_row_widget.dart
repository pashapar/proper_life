import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proper_life/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 64,
          child: Column(
            children: <Widget>[
              const SocialMediaButton(
                  onPressLink: 'https://www.instagram.com/paashapp/',
                  icon: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xfffa7e1e),
                    size: 35,
                  )),
              Text(
                '@proper.life',
                style: theme.textTheme.bodySmall!
                    .copyWith(color: theme.primaryColor, fontSize: 10),
              )
            ],
          ),
        ),
        const SocialMediaButton(
          icon: FaIcon(
            FontAwesomeIcons.telegram,
            color: Color(0xff0088cc),
            size: 35,
          ),
        ),
        const SocialMediaButton(
            icon: FaIcon(
          FontAwesomeIcons.viber,
          color: Color(0xff7360f2),
          size: 35,
        )),
        const SocialMediaButton(
            icon: FaIcon(
          FontAwesomeIcons.whatsapp,
          color: Color(0xff25d366),
          size: 35,
        )),
        const SocialMediaButton(
            icon: Icon(
          Icons.mail_outline_outlined,
          color: Color(0xffc71610),
          size: 35,
        ))
      ],
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final onPressLink;
  final icon;

  const SocialMediaButton({
    super.key,
    this.onPressLink,
    required this.icon,
  });

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _onOpen(UrlElement(onPressLink));
        },
        icon: icon);
  }
}
