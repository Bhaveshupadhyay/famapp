import 'package:cached_network_image/cached_network_image.dart';
import 'package:fampay/core/utils/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/convert.dart';
import '../../core/utils/launch_url.dart';
import '../../data/models/card.dart';

class CardHC1 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC1({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    
    return InkWell(
      onTap: (){
        if(card.url!=null){
          LaunchUrl.launchWebUrl(card.url!);
        }
      },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
        decoration: BoxDecoration(
          color: Convert.getColorFromHex(card.bgColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50.w,
              child: AspectRatio(
                aspectRatio: card.icon?.aspectRatio?.toDouble()??10/9,
                child: CachedNetworkImage(imageUrl:card.icon?.imageUrl?? AppUrls.errorImgUrl),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: '${(card.formattedTitle?.entities.length??0)>=1 ?
                            card.formattedTitle?.entities[0].text : ''}',
                            style: theme.textTheme.titleSmall?.
                            copyWith(
                                color: Convert.getColorFromHex(card.formattedTitle?.entities[0].color),
                                fontSize: 18.sp,
                            ),
                            children: [
                              TextSpan(
                                text: '${card.formattedTitle?.text.replaceAll('{}', '')}',
                                style: theme.textTheme.titleSmall?.
                                copyWith(
                                    color: Colors.white,
                                    fontSize: 18.sp
                                ),
                              ),
                              if((card.formattedTitle?.entities.length??0)>=2)
                                TextSpan(
                                  text: '${card.formattedTitle?.entities[1].text} ',
                                  style: theme.textTheme.titleSmall?.
                                  copyWith(
                                      color: Convert.getColorFromHex(card.formattedTitle?.entities[1].color),
                                      fontSize: 12.sp
                                  ),
                                ),
                            ],
                        ),
                      maxLines: 1,
                    ),
                    if(card.formattedDescription?.entities.isNotEmpty??false)
                      RichText(
                        text: TextSpan(
                            text: '${(card.formattedDescription?.entities.length??0)>=1 ?
                            card.formattedDescription?.entities[0].text : ''}',
                            style: theme.textTheme.bodySmall?.
                            copyWith(
                                color: Convert.getColorFromHex(card.formattedDescription?.entities[0].color),
                                fontSize: 18.sp
                            ),
                            children: [
                              TextSpan(
                                text: card.formattedDescription?.text.replaceAll('{}', '')??'',
                                style: theme.textTheme.bodySmall?.
                                copyWith(
                                    color: Colors.white,
                                    fontSize: 18.sp
                                ),
                              ),
                              if((card.formattedDescription?.entities.length??0)>=2)
                                TextSpan(
                                  text: '${card.formattedDescription?.entities[1].text??''} ',
                                  style: theme.textTheme.bodySmall?.
                                  copyWith(
                                      color: Convert.getColorFromHex(card.formattedDescription?.entities[1].color),
                                      fontSize: 12.sp
                                  ),
                                ),
                            ]
                        ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
