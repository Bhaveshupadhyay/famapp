import 'package:cached_network_image/cached_network_image.dart';
import 'package:fampay/core/utils/convert.dart';
import 'package:fampay/core/utils/launch_url.dart';
import 'package:fampay/cubit/saved_card/saved_card_cubit.dart';
import 'package:fampay/cubit/slider_cubit/slider_cubit.dart';
import 'package:fampay/data/models/cta.dart';
import 'package:fampay/core/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/saved_card.dart';
import '../../data/models/card.dart';

class CardHC3 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC3({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SliderCubit(),),
        BlocProvider(create: (context)=>SavedCardCubit()..loadSavedCard(cardId: card.id),)
      ],
      child: BlocBuilder<SavedCardCubit,SavedCardState>(
        builder: (context,savedCardState) {
          if(savedCardState is SavedCardLoading){
            return const Loading();
          }
          else if(savedCardState is SavedCardLoaded){
            if(savedCardState.savedCard.isDismiss ||
                (savedCardState.savedCard.isRemind && !savedCardState.isAppReloaded)){
              return const SizedBox.shrink();
            }
          }
          return BlocBuilder<SliderCubit,bool>(
            builder: (BuildContext context, bool showButtons) {
              return InkWell(
                onLongPress: (){
                  context.read<SliderCubit>().changeSliderState();
                },
                child: SizedBox(
                  width: width,
                  child: AspectRatio(
                    aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 8/9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Visibility(
                              visible: showButtons,
                              child: InkWell(
                                onTap: ()=>
                                    context.read<SliderCubit>().changeSliderState(),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: ()=>
                                              context.read<SavedCardCubit>()
                                                  .saveCard(saveCard: SavedCard(cardId: card.id,isRemind: true)),
                                            child: _btn(text: 'remind later', assetPath: 'assets/icons/ic_notify.svg')
                                        ),

                                        InkWell(
                                            onTap: ()=>
                                                context.read<SavedCardCubit>()
                                                    .saveCard(saveCard: SavedCard(cardId: card.id,isDismiss: true)),
                                            child: _btn(text: 'dismiss now', assetPath: 'assets/icons/ic_dismiss.svg')
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            AspectRatio(
                              aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 16/9,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: InkWell(
                                  onTap: (){
                                    if(card.url!=null){
                                      LaunchUrl.launchWebUrl(card.url!);
                                    }
                                  },
                                  child: Container(
                                    padding:  EdgeInsets.symmetric(vertical: 0.03.sh,
                                        horizontal: 0.09.sw
                                    ),
                                    decoration: BoxDecoration(
                                        color: Convert.getColorFromHex(card.bgColor),
                                        borderRadius: BorderRadius.circular(12.r),
                                        image: DecorationImage(
                                            image: NetworkImage(card.bgImage?.imageUrl??''),
                                            fit: BoxFit.fill
                                        )
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if(card.icon!=null)
                                          card.icon?.imageType == 'asset'?
                                          SizedBox(
                                            width: 50.w,
                                            child: AspectRatio(
                                              aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                                              child: SvgPicture.asset(
                                                'assets/icons/${card.icon?.imageUrl??'ic_error.svg'}',
                                              ),
                                            ),
                                          )
                                              :
                                          SizedBox(
                                            width: 40.w,
                                            child: AspectRatio(
                                              aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                                              child: CachedNetworkImage(imageUrl:card.icon?.imageUrl??'',),
                                            ),
                                          ),

                                        SizedBox(height: 5.h,),

                                        _richText(theme: theme),
                                        SizedBox(height: 10.h,),

                                        for(Cta cta in card.cta!)
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 13.h,horizontal: 40.w),
                                            decoration: BoxDecoration(
                                                color: Convert.getColorFromHex(cta.bgColor),
                                                borderRadius: BorderRadius.circular(6.r)
                                            ),
                                            child: Text(
                                              cta.text,
                                              style: Theme.of(context).textTheme.bodySmall?.
                                              copyWith(
                                                color: Convert.getColorFromHex(cta.textColor),
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }

  Widget _richText({required ThemeData theme,}){
    final formattedTexts=card.formattedTitle?.text.split('{}'); //splitting the formattedTitle by {}
    final entities=card.formattedTitle?.entities;

    final List<TextSpan> textSpan=[];
    if(formattedTexts!=null && entities!=null){
      /*Iterating over formattedTexts and entities, and increasing the entityIndex value by 1
      if the formattedText is empty (i.e., it's a placeholder for inserting the entity text) */
      for(int formatIndex=0,entityIndex=0; formatIndex<formattedTexts.length; formatIndex++){

        if(formattedTexts[formatIndex].trim().isNotEmpty){
          textSpan.add(TextSpan(
            text: formattedTexts[formatIndex],
          ));
        }

        else{
          final entity=entities[entityIndex];

          textSpan.add(TextSpan(
              text: entity.text,
              style: TextStyle(
                  color: Convert.getColorFromHex(entity.color),
                  fontSize: entity.fontSize?.toDouble()
              )
          ));
          entityIndex++;
        }
      }
    }
    return RichText(
        text: TextSpan(
            children: textSpan,
            style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 30
            )
        )
    );
  }


  Widget _btn({required String text, required String assetPath}){
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: const Color(0xffF7F6F3),
          borderRadius: BorderRadius.circular(12.r)
      ),
      child: Column(
        children: [
          SvgPicture.asset(assetPath,),
          Text(text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 11.sp
            ),
          ),

        ],
      ),
    );
  }

}
