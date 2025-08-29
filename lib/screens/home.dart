import 'package:fampay/core/constant/card_design_type.dart';
import 'package:fampay/core/theme/app_color.dart';
import 'package:fampay/cubit/data_cubit/data_cubit.dart';
import 'package:fampay/cubit/data_cubit/data_state.dart';
import 'package:fampay/data/models/card_group.dart';
import 'package:fampay/widgets/card_widget/card_hc1.dart';
import 'package:fampay/widgets/card_widget/card_hc3.dart';
import 'package:fampay/widgets/card_widget/card_hc5.dart';
import 'package:fampay/widgets/card_widget/card_hc9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/famx_page.dart';
import '../widgets/card_widget/card_hc6.dart';
import '../core/common/loading.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<DataCubit>().loadData();
      },
      child: BlocBuilder<DataCubit,DataState>(
        builder: (BuildContext context, DataState state) {
          if(state is DataLoading){
            return const Loading();
          }
          else if(state is DataLoaded<List<FamxPayPage>>){
            FamxPayPage famxPayPage= state.data[0];

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),

              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r)
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    for(CardGroup cardGroup in famxPayPage.hcGroups)
                      if(cardGroup.designType.toUpperCase() == CardDesignType.hc3)
                        _hc3(context, cardGroup)
                      else if(cardGroup.designType.toUpperCase() == CardDesignType.hc6)
                        _hc6(context, cardGroup)
                      else if(cardGroup.designType.toUpperCase() == CardDesignType.hc5)
                        _hc5(context, cardGroup)
                        else if(cardGroup.designType.toUpperCase() == CardDesignType.hc9)
                          _hc9(context, cardGroup)
                          else if(cardGroup.designType.toUpperCase() == CardDesignType.hc1)
                            _hc1(context, cardGroup),


                    SizedBox(height: 30.h,),
                  ],
                ),
              ),
            );
          }
          else if(state is DataFailed){
            return Center(
              child: Text(state.errorMsg,
                style: Theme.of(context).textTheme.titleSmall?.
                copyWith(
                  color: Colors.black,
                  fontSize: 20.sp
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }


  Widget _hc3(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20.w : 0,right: 20.w,),
                  child: CardHC3(card: cardGroup.cards[index],width: 0.8.sw,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
      child: CardHC3(card: cardGroup.cards[0]),
    );
  }

  Widget _hc6(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20.w : 0,right: 20.w,),
                  child: CardHC6(card: cardGroup.cards[index],width: 0.8.sw,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(cardGroup.cards.length, (index){
            return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index<cardGroup.cards.length-1? 10.w:0,),
                  child: CardHC6(card: cardGroup.cards[index]),
                )
            );
          })
          // CardHC1(card: cardGroup.cards[0]),
        ],
      ),
    );
  }

  Widget _hc5(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20.w : 0,right: 20.w,),
                  child: CardHC5(card: cardGroup.cards[index],width: 0.8.sw,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(cardGroup.cards.length, (index){
            return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index<cardGroup.cards.length-1? 10.w:0,),
                  child: CardHC5(card: cardGroup.cards[index]),
                )
            );
          })
        ],
      ),
    );
  }

  Widget _hc9(BuildContext context, CardGroup cardGroup){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child : SizedBox(
          height: (cardGroup.height?.toDouble()??300).h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20.w : 0,right: 20.w,),
                  child: CardHC9(card: cardGroup.cards[index],width: 0.8.sw,),
                );
              },
            itemCount: cardGroup.cards.length,
          ),
        )
    );
  }

  Widget _hc1(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20.w : 0,right: 20.w,),
                  child: CardHC1(card: cardGroup.cards[index],width: 0.8.sw,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(cardGroup.cards.length, (index){
            return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index<cardGroup.cards.length-1? 10.w:0,),
                  child: CardHC1(card: cardGroup.cards[index]),
                )
            );
          })
        ],
      ),
    );
  }
}
