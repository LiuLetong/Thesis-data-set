foreach var of varlist 时长天 {
        qui sum `var'
        qui replace `var'=365 if `var'==.
}

#stset 时长天 , id( 序号 ) failure( 是否成功渗透 == 1)
stset 时长天 , failure( 是否成功渗透 == 1)
streg 内购项目 语言数量 评分 国家影响力 d c a g e ,  nolog dist(logn)//对数正态
stdescribe
stcurve, hazard //画风险函数图

**********************4.7更新*******************************************

asdoc pwcorr 内购项目 语言数量 评分 时长天 国家影响力 d c a g e, star(all) replace

generate sensord = sensortower评分* d
generate sensorc = sensortower评分* c
generate sensora = sensortower评分* a
generate sensorg = sensortower评分* g
generate sensore = sensortower评分* e

streg 内购项目 语言数量 评分 国家影响力 d c a g e ,  nolog dist(ggamma)
est store model1

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensord,  nolog dist(ggamma)
est store model2

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensorc,  nolog dist(ggamma)
est store model3

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensora,  nolog dist(ggamma)
est store model4

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensorg,  nolog dist(ggamma)
est store model5

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensore,  nolog dist(ggamma)
est store model6

esttab model1 model2 model3 model4 model5 model6 using text.rtf

****************4.10更新***************************
streg 内购项目 语言数量 评分 国家影响力 d c a g e ,  nolog dist(logl)//对数逻辑
streg 内购项目 语言数量 评分 国家影响力 d c a g e ,  nolog dist(weib)//威布尔分布
streg 内购项目 语言数量 评分 国家影响力 d c a g e ,  nolog dist(e)//指数
streg 内购项目 语言数量 评分 国家影响力 d c a g e ,  nolog dist(ggamma)//伽马分布
**4.10,90个应用，gamma分布的AIC值最小****

**************4.11enter问题解决*****************************
replace 时长天= 时长天+1
asdoc pwcorr 时长天 d c a g e 内购项目 语言数量 评分 国家影响力 sensortower评分 可见度 国际化,star(all) replace

generate sensord = sensortower评分* d
generate sensorc = sensortower评分* c
generate sensora = sensortower评分* a
generate sensorg = sensortower评分* g
generate sensore = sensortower评分* e

streg 内购项目 语言数量 评分 国家影响力,  nolog dist(ggamma)
est store model1

streg 内购项目 语言数量 评分 国家影响力 d c a g e,  nolog dist(ggamma)
est store model2

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分,  nolog dist(ggamma)
est store model3

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensord,  nolog dist(ggamma)
est store model4

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensorc,  nolog dist(ggamma)
est store model5

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensora,  nolog dist(ggamma)
est store model6

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensorg,  nolog dist(ggamma)
est store model7

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensore,  nolog dist(ggamma)
est store model8

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensora sensord sensore sensorg sensorc,  nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text411-102.doc

*******************4.13***********************************************************
*关于方差膨胀因子检验，只要用简单回归即可，命令为estat vif，只要vif小于10就行****
asdoc pwcorr 时长天 d c a g e 内购项目 语言数量 国家影响力 sensortower评分 国际化,star(all) replace

generate interd = 国际化* d
generate interc = 国际化* c
generate intera = 国际化* a
generate interg = 国际化* g
generate intere = 国际化* e

streg 内购项目 语言数量 评分 国家影响力, r nolog dist(ggamma)
est store model1

streg 内购项目 语言数量 评分 国家影响力 d c a g e, r nolog dist(ggamma)
est store model2

streg 内购项目 语言数量 评分 国家影响力 d c a g e 国际化,r  nolog dist(ggamma)
est store model3

streg 内购项目 语言数量 评分 国家影响力 d c a g e interd, r nolog dist(ggamma)
est store model4

streg 内购项目 语言数量 评分 国家影响力 d c a g e interc, r nolog dist(ggamma)
est store model5

streg 内购项目 语言数量 评分 国家影响力 d c a g e intera, r nolog dist(ggamma)
est store model6

streg 内购项目 语言数量 评分 国家影响力 d c a g e interg, r nolog dist(ggamma)
est store model7

streg 内购项目 语言数量 评分 国家影响力 d c a g e intere, r nolog dist(ggamma)
est store model8

streg 内购项目 语言数量 评分 国家影响力 d c a g e 国际化 interd interc intera interg intere, r nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text413-2.rtf 

****************************4.18********************************************
//稳健性
stcox 内购项目 语言数量 评分 国家影响力,r nohr nolog
est store model1

stcox 内购项目 语言数量 评分 国家影响力 d c a g e,r nohr nolog
est store model2

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分,r nohr nolog
est store model3

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensord,r nohr nolog
est store model4

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensorc,r nohr nolog
est store model5

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensora,r nohr nolog
est store model6

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensorg,r nohr nolog
est store model7

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensore,r nohr nolog
est store model8

stcox 内购项目 语言数量 评分 国家影响力 d c a g e sensora sensord sensore sensorg sensorc,r nohr nolog
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text418robust.rtf
************************4.21*****************************
streg 内购项目 语言数量 评分 国家影响力,  nolog dist(ggamma)
est store model1

streg 内购项目 语言数量 评分 国家影响力 d c a g e,  nolog dist(ggamma)
est store model2

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分,  nolog dist(ggamma)
est store model3

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensord,  nolog dist(ggamma)
est store model4

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorc,  nolog dist(ggamma)
est store model5

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora,  nolog dist(ggamma)
est store model6

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorg,  nolog dist(ggamma)
est store model7

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensore,  nolog dist(ggamma)
est store model8

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora sensord sensore sensorg sensorc,  nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text421.doc

****************************4.25*****************************************************
streg 内购项目 语言数量 评分 国家影响力, r nolog dist(ggamma)
est store model1

streg 内购项目 语言数量 评分 国家影响力 d c a g e, r nolog dist(ggamma)
est store model2

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分, r nolog dist(ggamma)
est store model3

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensord, r nolog dist(ggamma)
est store model4

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorc, r nolog dist(ggamma)
est store model5

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora, r nolog dist(ggamma)
est store model6

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorg, r nolog dist(ggamma)
est store model7

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensore, r nolog dist(ggamma)
est store model8

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora sensord sensore sensorg sensorc, r nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text425.rtf

****************4.26**************************
tabstat 时长天 d c a g e 内购项目 语言数量 评分 国家影响力 sensortower评分 可见度 国际化 ,s(N mean min max sd) f(%12.3f) c(s)
//描述性统计
//更改了第38个应用数据，STAT数据集改变，初始excel改变，稳健性检验STAT没变
asdoc pwcorr 时长天 d c a g e 内购项目 语言数量 评分 国家影响力 sensortower评分 可见度 国际化,star(all) replace
streg 内购项目 语言数量 评分 国家影响力, r nolog dist(ggamma)
est store model1

streg 内购项目 语言数量 评分 国家影响力 d c a g e, r nolog dist(ggamma)
est store model2

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分, r nolog dist(ggamma)
est store model3

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensord, r nolog dist(ggamma)
est store model4

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorc, r nolog dist(ggamma)
est store model5

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora, r nolog dist(ggamma)
est store model6

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorg, r nolog dist(ggamma)
est store model7

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensore, r nolog dist(ggamma)
est store model8

streg 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora sensord sensore sensorg sensorc, r nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text426.rtf

//控制应用
streg 序号 内购项目 语言数量 评分 国家影响力, r nolog dist(ggamma)
est store model1

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e, r nolog dist(ggamma)
est store model2

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分, r nolog dist(ggamma)
est store model3

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensord, r nolog dist(ggamma)
est store model4

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorc, r nolog dist(ggamma)
est store model5

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora, r nolog dist(ggamma)
est store model6

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorg, r nolog dist(ggamma)
est store model7

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensore, r nolog dist(ggamma)
est store model8

streg 序号 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora sensord sensore sensorg sensorc, r nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text426.rtf

**********5.16控制国家*********************
streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力, r nolog dist(ggamma)
est store model1

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e, r nolog dist(ggamma)
est store model2

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分, r nolog dist(ggamma)
est store model3

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensord, r nolog dist(ggamma)
est store model4

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorc, r nolog dist(ggamma)
est store model5

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora, r nolog dist(ggamma)
est store model6

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensorg, r nolog dist(ggamma)
est store model7

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensore, r nolog dist(ggamma)
est store model8

streg 序号 上线国指标 内购项目 语言数量 评分 国家影响力 d c a g e sensortower评分 sensora sensord sensore sensorg sensorc, r nolog dist(ggamma)
est store model9

esttab model1 model2 model3 model4 model5 model6 model7 model8 model9 using text516.rtf

******************KM *******************************************************************************
stset 时长天 , failure( 是否成功渗透 == 1)
sts graph, by(标记) 
graph export figure1.png
****************8.19 vif************************
reg 时长天 内购项目 语言数量 评分 国家影响力 d c a g e
asdoc vif
