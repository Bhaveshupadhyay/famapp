import 'package:cached_network_image/cached_network_image.dart';
import 'package:fampay/data/models/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/convert.dart';
import '../../core/utils/launch_url.dart';

class CardHC5 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC5({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return InkWell(
      onTap: (){
        if(card.url!=null){
          LaunchUrl.launchWebUrl(card.url!);
        }
      },
      child: SizedBox(
        width:  width,
        child: AspectRatio(
          aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 16/9,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 20.w),
            decoration: BoxDecoration(
                color: Convert.getColorFromHex(card.bgColor),
              borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                    image: NetworkImage(card.bgImage?.imageUrl??''),
                    fit: BoxFit.fill
                )
            ),
            child: Row(
              children: [
                if(card.icon!=null)
                  card.icon?.imageType == 'asset'?
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: card.icon?.aspectRatio?.toDouble()?? 10/9,
                      child: SvgPicture.asset(
                        'assets/icons/${card.icon?.imageUrl??'ic_error.svg'}',
                        height: 80.h,
                        width: 90.w,
                      ),
                    ),
                  )
                      :
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: card.icon?.aspectRatio?.toDouble()?? 10/9,
                      child: CachedNetworkImage(imageUrl: card.icon?.imageUrl??'',),
                    ),
                  ),
                SizedBox(width: 15.w,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h,),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: '${(card.formattedTitle?.entities.length??0)>=1 ?
                              card.formattedTitle?.entities[0].text : ''}',
                              style: theme.textTheme.titleSmall?.
                              copyWith(
                                  color: Convert.getColorFromHex(card.formattedTitle?.entities[0].color),
                                  fontSize: 35.sp
                              ),
                              children: [
                                TextSpan(
                                  text: '${card.formattedTitle?.text.replaceAll('{}', '')}',
                                  style: theme.textTheme.titleSmall?.
                                  copyWith(
                                      color: Colors.white,
                                      fontSize: 35.sp
                                  ),
                                ),
                                if((card.formattedTitle?.entities.length??0)>=2)
                                  TextSpan(
                                  text: '${card.formattedTitle?.entities[1].text} ',
                                  style: theme.textTheme.bodySmall?.
                                  copyWith(
                                      color: Convert.getColorFromHex(card.formattedTitle?.entities[1].color),
                                      fontSize: 15.sp
                                  ),
                                ),
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 5.h,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
