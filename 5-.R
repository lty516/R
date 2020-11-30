#### 기본 내장 그래프 ####

# plot()
# plot(y축 데이터, 옵션 )
# plot(x축 데이터. y축 데이터, 옵션 )
?plot

y <- c(1,1,2,2,3,3,4,4,5,5)
plot(y)

x <- 1:10
y <- 1:10
plot(x, y)

# 옵션
plot(x, y, xlim = c(0,20), ylim = c(0,30), main = 'Graph',type = "o",pch =3) 

x <- runif(100)
y <- runif(100)
plot(x, y, pch = ifelse(y>0.5,21,20))

# barplot(), hist(), pie(), mosaicplot(), pair(), persp(), contour(), ...

# 그래프 배열
head(mtcars)
?mtcars
str(mtcars)

# 그래프 4개 그리기
par(mfrow = c(2,2))
plot(mtcars$wt, mtcars$mpg) 
plot(mtcars$wt, mtcars$disp) 
hist(mtcars$wt)
boxplot(mtcars$wt)

par(mfrow = c(1,1))
plot(mtcars$wt, mtcars$mpg) # 무게와 연비 음의 상관관계

# 행 또는 열마다 그래프 개수를 다르게 설정
?layout
layout(matrix(c(1,2,3,3),2,2,byrow = T)) 

hist(mtcars$wt)
hist(mtcars$mpg)
hist(mtcars$disp)

# arrows
x <- c(1, 3, 6, 8, 9)
y <- c(12, 56, 78, 32, 9)
plot(x,y)
arrows(3,56,1,12) 
text(4,40,"이것은 샘플입니다.",srt=55)

# 꽃잎 그래프 
x <- c(1,1,1,2,2,2,2,2,2,3,3,4,5,6,6,6)
y <- c(2,1,4,2,3,2,2,2,2,2,1,1,1,1,1,1)
plot(x,y)

z <- data.frame(x,y)
sunflowerplot(z) 

# 별 그래프 / 나이팅게일 그래프
# 데이터의 전체적인 윤관을 살펴보는 그래프 
# 데이터 항목에 대한 변화의 정도를 한눈에 파악 

head(mtcars)
str(mtcars)
stars(mtcars[1:4],flip.labels = F,key.loc = c(13,1.5),draw.segments = T) # draw.segments = T << 나이팅게일 차트 생성

# symbols
x <- c(1,2,3,4,5)
y <- c(2,3,4,5,6)
z <- c(10,5,100,20,10)

symbols(x,y,z)


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

#### ggplot2 ####
# http://www.r-graph-gallery.com/portfolio/ggplot2-package/
# https://ggplot2.tidyverse.org/

# 레이어 지원
#   1) 배경 설정
#   2) 그래츠 추가(점, 막대, 선, ...)
#   3) 설정 추가(축 범위, 범례, 색, 표식, ...)
# install.packages("ggplot2")
library(ggplot2)

# 산포도
head(mpg)

# aes():x좌표 , y좌표
ggplot(data = mpg, aes(x = displ, y = hwy))
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

# cty와 hwy의 상관 관계(산포도)
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

# midwest데이터를 이용하여 전체인구(poptotal)와 아시아인구(popasian)간에 어던 관계가 있는지 알아보려고 한다. x축은 전체인구, y축은 아시아인구로 된 산포도를 작성. 단, 전체인구는 30만명 이하, 아시아 인구는 1만명 이하인 지역만 산점도로 표시 

options(scipen = 99) # 지수를 숫자로 표현 

ggplot(data = midwest, aes(x = poptotal, y = popasian)) + geom_point() + xlim(0,300000) + ylim(0,10000) 


# 막대 그래프 : geom_col() : > 두개의 변수
# 히스토그램 : geom_bar()  : > 하나의 변수 
library(dplyr)

# 구동방식(drv)별로 고속도로 평균 연비 조회하고 결과를 막대 그래프로 출력
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))

# reorder(): 정렬   -로 오름차순 낼림차순 결절
ggplot(df_mpg, aes(reorder(drv, mean_hwy), mean_hwy)) +  geom_col() 
ggplot(mpg,aes(drv)) + geom_bar()      
ggplot(mpg,aes(hwy))+ geom_bar()

# 어떤 회사에서 생산한 'suv' 차종의 도시 연비가 높은지 알아보려고 한다."suv"차종을 대상으로 평균 cty가 가장 높은 회사 다섯곳을 막대 그래프로 출력( 막대는 연비가 높은 순으로 정렬)

suv_df <- mpg %>% group_by(manufacturer)  %>% filter(class == 'suv') %>% summarise(mean_cty = mean(cty)) %>% arrange(desc(mean_cty)) %>% head(5)

ggplot(data = suv_df, aes(reorder(manufacturer, -mean_cty), mean_cty)) + geom_col()

# 자동차 중에서 어떤 종류(class)가 가장 많은지 알아보려고 한다. 자동차 종류별 빈도를 막대 그래프로 출력
table(mpg$class)
ggplot(mpg,aes(class)) +geom_bar()

# 선 그래프 :geom_line()
head(economics)
tail(economics)

ggplot(economics,aes(date,unemploy))+ geom_line()
ggplot(economics,aes(date,psavert))+ geom_line()

# 상자 그래프 : geom_boxplot()
ggplot(mpg,aes(drv,hwy)) + geom_boxplot()

# class가 "compact","subcompact","suv"인 자동차의 cty가 어떻게 다른지 비교해 보려고 한다. 세차종의 cty를 나타낸 상자 그래프 출력

class_mgp <- mpg %>% filter(class %in% c('compact','subcompact','suv'))
ggplot(class_mgp,aes(class,cty)) + geom_boxplot()

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

#### interactive graph ####
# https://plot.ly/ggplot2

install.packages("plotly")
library(plotly)

p <- ggplot(mpg,aes(displ,hwy, col=drv)) + geom_point()
ggplotly(p)

head(diamonds)
p <- ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = 'dodge')
ggplotly(p)

# 시계열 데이터
install.packages('dygraphs')
library(dygraphs)

head(economics)
str(economics)

d <- ggplot(economics,aes(date,unemploy))+ geom_line()
dygraph(d)

# 연속적인 날짜 형식으로 변환 :xts type
library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)
str(eco)

dygraph(eco)

dygraph(eco) %>% dyRangeSelector()

# 두데이터를 한 그래프에 담기
eco_a <- xts(economics$psavert, order.by = economics$date)
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b)
colnames(eco2) <- c('psavert','unemploy')
head(eco2)

dygraph(eco2) %>% dyRangeSelector()

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
#### 지도 그래프 (단계 구분도, Choropleth Map)####
install.packages("ggiraphExtra")
library(ggiraphExtra)

head(USArrests)
tail(USArrests)

library(tibble)

# 인덱스를 컬럼으로 바꿔주는 함수 
crime <- rownames_to_column(USArrests,var = "state")
head(crime)
str(crime)

crime$state <- tolower(crime$state)
head(crime)

install.packages("maps")

state_map <- map_data("state")
head(state_map)
str(state_map)

install.packages("mapproj")

ggChoropleth(data = crime, aes(fill= Murder, map_id = state),map=state_map, interactive = T)

# 대한민국 지도 만들기 
# https://github.com/cardiomoon/kormaps2014

install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

head(korpop1)
str(korpop1)

head(kormap1)
str(kormap1)

# 인코딩 변경 
korpop1<- changeCode(korpop1)
str(changeCode(korpop1))
head(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1,pop= '총인구_명',name= '행정구역별_읍면동')
str(korpop1)

ggChoropleth(data=korpop1,aes(fill=pop, map_id= code,tooltip=name), map = kormap1, interactive = T)

library(ggplot2)

tbc <- changeCode(tbc)
ggChoropleth(data=tbc,aes(fill=NewPts, map_id= code, tooltip = name), map = kormap1, interactive = T)

#### 워드 클라우드 ####
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

library(KoNLP)
library(dplyr)


