import 'package:examen_cmo/theme/theme.dart';

//widget que permite crear una card para mostrar los 3 componentes del menú

class CardMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final GestureTapCallback onTapDetail;

  const CardMenu(
      {super.key,
      required this.title,
      required this.icon,
      required this.iconColor,
      required this.onTapDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ListTile(
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios, color: iconColor),
          onTap: onTapDetail),
    );
  }
}
