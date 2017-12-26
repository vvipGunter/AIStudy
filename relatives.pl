/*************************************************
            Family Relatives
**************************************************/
grandfather(henanm,zhangqiangqiang).  
grandfather(guangshuim,yinyanxi).
grandfather(nashuihem,zhangweiyan).
grandfather(tiebanqiaom,yinlong).
grandmother(henanf,zhangqiangqiang).
grandmother(guangshuif,yinyanxi).
grandmother(nashuihef,zhangweiyan).
grandmother(tiebanqiaof,yinlong).

outergrandfather(guangshuim,zhangqiangqiang).
outergrandfather(liaoxiangm,yinyanxi).
outergrandfather(guangshuim,zhangweiyan).
outergrandfather(guangshuim,yinlong).
outergrandmother(guangshuif,zhangqiangqiang).
outergrandmother(liaoxiangf,yinyanxi).
outergrandmother(guangshuif,zhangweiyan).
outergrandmother(guangshuif,yinlong).

father(zhangxunshun,zhangqiangqiang).
father(zhangxunshun,zhangqiangqiang1).
father(zhangxunshun,zhanghongyang).
father(zhangxunshun,zhanghongliu).
father(zhangsanxi,zhangweiyan).
father(yinchangshou,yindan).
father(yinchangshou,yinliang).
father(yinchangshou,yintiao).
father(yinchangshou,yinlong).
father(yinchangguo,yinyanxi).

mother(yinguohua,zhangqiangqiang).
mother(yinguohua,zhanghongyang).
mother(yinguohua,zhanghongliu).
mother(yinjianhua,zhangweiyan).
mother(zhaoxiaofang,yindan).
mother(zhaoxiaofang,yinliang).
mother(zhaoxiaofang,yintiao).
mother(zhaoxiaofang,yinlong).
mother(lieshuxia,yinyanxi).

wife(yinguohua,zhangxunshun).
wife(yinjianhua,zhangsanxi).
wife(lieshuxia,yinchangguo).
wife(zhaoxiaofang,yinchangshou).


/*********************************
        person facts
**********************************/
 person(zhangqiangqiang,sex(male),21,1.73,'college').
 person(zhangqiangqiang1,sex(male),22,1.72,'college1'). 
 /* just for test brothers */
 person(yinyanxi,sex(male),16,1.68,'junor school').
 person(zhangweiyan,sex(male),16,1.75,'xiao xue').
 person(yinlong,sex(male),20,1.70,'senir school').
 person(zhangxunshun,sex(male),50,1.69,'unknown').
 person(yinchangshou,sex(male),47,1.74,'unknown').
 person(yinchangguo,sex(male),45,1.73,'xiao xue').
 person(zhangsanxi,sex(male),42,1.71,'xiao xue').
 person(henanm,sex(male),80,1.79,'unknown').
 person(guangshuim,sex(male),70,1.56,'unknown').
 person(nashuihem,sex(male),65,1.77,'unknown').
 person(tiebanqiaom,sex(male),60,1.78,'unkown').

 person(henanf,sex(female),70,1.66,'unknown').
 person(guangshuif,sex(female),60,1.68,'not read').
 person(nashuihef,sex(female),57,1.55,'not known').
 person(tiebanqiaof,sex(female),59,1.60,'not known').
 person(liaoxiangf,sex(female),61,1.69,'not known').
 person(yinguohua,sex(female),46,1.67,'senior school').
 person(yinjianhua,sex(female),42,1.66,'senior school').
 person(lieshuxia,sex(female),43,1.64,'xiao xue').
 person(zhaoxiaofang,sex(female),50,1.66,'xiao xue').
 person(zhanghongyang,sex(female),19,1.73,'xiao xue').
 person(zhanghongliu,sex(female),17,1.74,'college').
 person(yindan,sex(female),25,1.72,'junor school').
 person(yinliang,sex(female),23,1.65,'junor school').
 person(yintiao,sex(female),21,1.66,'junor school').

/************************
 *   All common rules  *
 ***********************/
/*首先应该判断这些是否存在及他们之间是否有这些关系等  TODO*/

is_male(X):-person(X,sex(male),_,_,_).
is_female(X):-person(X,sex(female),_,_,_).
person_info(Name,Sex,Age,Height,School):-person(Name,sex(Sex),Age,Height,School).

grandfather(X,Y):-father(X,Z),father(Z,Y).
grandmother(X,Y):-mother(X,Z),mother(Z,Y).
outergrandfather(X,Y):-father(X,M),mother(M,Y). 
outergrandmother(X,Y):-mother(X,M),mother(M,Y).
couple(H,W):-father(H,Z),mother(W,Z),is_male(H),is_female(W).
parents(X,H,W):-father(H,X),mother(W,X),is_male(H),is_female(W),H\=W.  
son(X,Y):-father(Y,X),X\=Y,is_male(X),is_male(Y).
son(X,Y):-mother(Y,X).
daughter(X,Y):-mother(Y,X),is_female(X),is_female(Y),!. 
daughter(X,Y):-father(Y,X),is_female(X),is_male(Y). 
sisters(X,Y):-father(Z,X),father(Z,Y),is_female(X),is_female(Y),is_male(Z),X\=Y.
/*
sisters(X,Y):-mother(Z,X),mother(Z,Y),is_female(X),is_female(Y),is_female(Z),X\=Y.
*/
brothers(X,Y):-father(Z,X),father(Z,Y),is_male(X),is_male(Y),is_male(Z),X\=Y.
brothers(X,Y):-grandfather(X,Z),grandfather(X,Y),is_male(Z),is_male(Y),Y\=Z.


/* to be test strictly, 最好采用递归定义这些规则*/  
uncle(X,Y):-brothers(X,Z),father(Z,Y),is_male(Z).
uncle(X,Y):-sisters(X,Z),father(Z,Y),is_male(Z).


 fact(0,1).
fact(1,1).
fact(N,M):- N=<1,
          fact(N,_)=1.
fact(N,M):- N1 is (N-1),
            fact(N1,M1),
            M is N*M1.

 























