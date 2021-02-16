import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_appc/common_widgets/theme.dart';

class ModelGrid {
  final String name;
  final String subtitle;
  final String ratings;
  final String logo_path;
  final String image_path;

  ModelGrid(
      {@required this.name,
      @required this.subtitle,
      @required this.ratings,
      @required this.logo_path,
      @required this.image_path});
}

class CardGrid extends StatelessWidget {
  final String name;
  final String rating;
  final String profile;
  final Function onPress;

  CardGrid(
      {@required this.name,
      @required this.rating,
      @required this.profile,
      this.onPress});

  get headStyle1 => TextStyle(
        fontSize: 14,
        color: Colors.white,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.hardLight,
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          profile,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.grey,
                        ],
                        stops: [
                          1.0,
                          1.0
                        ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        tileMode: TileMode.repeated),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.at,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Text(
                            name,
                            style: headStyle1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
