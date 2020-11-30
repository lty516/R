#### 기술 통계량 ####

# min(vec),max(vec)
# range(vec) :벡터를 대상으로 범위값을 구하는 함수 
# mean(vec), median(vec)
# sum(vec)
# order(vec) : 정렬
# rank(vec)
# sd(vec) : 표준편차 , var(vec)
# summary(vec)
# quantile(vec) : 사분위수 
# table(vec) : 빈도수 
# sample(x, y) : x범위에서 y만큼 샘플데이터를 생성하는 함수

# table()
# --- --- --- --- --- --- --- ---
aws =read.delim("../data/AWS_sample.txt",sep = "#")
str(aws)
aws
table(aws$AWS_ID)
table(aws$AWS_ID,aws$X.)

table(aws[,c("AWS_ID","X.")])

aws[2500:3100,"X."] = "modifed"
table(aws$AWS_ID,aws$X.)

prop.table(table(aws$AWS_ID))
prop.table(table(aws$AWS_ID))* 100

paste0(prop.table(table(aws$AWS_ID))* 100, "%")

# 기술 통계 함수의 모듈화
test <- read.csv("../data/test.csv",header = T)
head(test)

data_proc <- function(df){
  print(length(df))
  # 각 컬럼 단위로 빈도와 최댓값/최솟값 계산
  for (idx in 1:length(df)){
    cat(idx,"번째 컬럼의 빈도 분석 결과")
    print(table(df[idx]))
    cat("\n")
  }
  
  for (idx in 1:length(df)) {
    f <- table(df[idx])
    cat(idx, "번째 컬럼의 최댓값/최솟값 결과 : \t")
    cat("max=",max(f),",min=",min(f),"\n")
  } 
}

data_proc(test)

#### plyr ####
# -p.193

# plyr
# --- --- --- --- --- --- --- ---
install.packages("plyr")
library(plyr)

x <- data.frame(id = c(1,2,3,4,5,6),height = c(160,171,173,162,165,170))
y <- data.frame(id = c(5,4,1,3,2,7),weight = c(55,73,60,57,80,91))

xy <- join(x, y,by ="id", type = 'left')
xy

xy <- join(x, y,by ="id", type = 'right')
xy

xy <- join(x, y,by ="id", type = 'full')
xy

xy <- join(x, y,by ="id", type = 'inner')
xy

# 다중 키일 경우 
x <- data.frame(key1 = c(1,1,2,2,3),key2=c('a','b','c','d','e'),val=c(10,20,30,40,50))
y <- data.frame(key1 = c(3,2,2,1,1),key2=c('e','d','c','b','a'),val=c(500,400,300,200,100))

xy <- join(x,y,by =c('key1','key2'))
xy

# 기술 통계량 
# tapply() : 집단 변수를 대상으로 한번에 하나의 통계치를 구할 때 사용
# ddply() : 한번에 여러 개의 통깨를 구할 때 사용

head(iris)
unique(iris$Species)
class(iris$Species)

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species, sd)

#ddply에선 $으로 접근 불가
ddply(iris, .(Species), summarise, avg= mean(Sepal.Length))
ddply(iris, .(Species), summarise, avg= mean(Sepal.Length),std = sd(Sepal.Length),
      max=max(Sepal.Length), min = min(Sepal.Length))

#### dplyr ####
#--- --- --- --- --- --- --- --- ---
install.packages("dplyr")
library(dplyr)
help(package=  dplyr)

# filter()    :  행 추출 -> subset() 
# select()    :  열 추출 -> data[,c]
# arrange()   :   정 렬  -> order(), sort()
# mutate()    :  열 추가 -> transform()
# summarize() :  통걔치 산출 -> aggregate()
# group_by()  :  집단별로 나누기 -> subset(), tapply(), aggregate()
# left_join() :  데이터 합치기(열) -> cbind()
# bind_rows() :  데이터 합치기(행) -> rbind()

exam <- read.csv(("../data/csv_exam.csv"))
exam

# filter()

# 1반 학생들의 데이터 추출
exam[exam$class == 1,] # 기본 문법
filter(exam,class ==1) # filter 사용
exam %>% filter(class ==1)

# 2반이면서 영어점수가 80점 이상인 데이터 추출
exam[exam$class == 2 & exam$english >=80,]
filter(exam, class ==2, english >= 80)
exam %>% filter(class ==2 & english >= 80)

# 1,3,5반에 해당하는 데이터를 추출
exam %>% filter(class ==1 | class ==3 | class==5)
exam %>% filter(class %in% c(1,3,5))

#select()

# 수학점수만 추출
exam[,3]
exam %>% select(math)

# 반, 수학,영어점수 추출
exam %>% select(class, math, english)

# 수학점수를 제외하고 나머지 컬럼을 추출
exam %>% select(-math)

# 1반 학생들의 수학점수만 추출 
exam %>% filter(class ==1) %>% select(math) %>% head(2)

# arrange()
exam %>% arrange(math)         # 오름차순
exam %>% arrange(desc(math))   # 내림차순
exam %>% arrange(class, math)  # 2차 정렬 

# mutate()
exam$sum <- exam$math +exam$english + exam$science
head(exam)

exam <- exam %>% mutate(total=math+english+science, mean= total/3)
exam

# summarize()
exam %>% summarize(mean_math=mean(math))

# group_by()
exam %>% group_by(class) %>%
  summarise(mean_math = mean(math), sum_math = sum(math),median_math = median(math),n=n()) # n() :개수를 구하는 함수

# left_join()
test1 <- data.frame(id=c(1,2,3,4,5), midterm = c(60,70,80,90,85))
test2 <- data.frame(id=c(1,2,3,4,5), midterm = c(70,83,65,95,80))

total <- left_join(test1, test2, by="id")
total

test3 <- data.frame(class=c(1,2,3,4,5), teacher = c("kim","lee","park","choi","shin"))
test3

exam_new = left_join(exam, test3, by="class")
head(exam_new)

# bind_rows()
group1 <- data.frame(id=c(1,2,3,4,5), test = c(60,70,80,90,85))
group2 <- data.frame(id=c(1,2,3,4,5), test = c(70,83,65,95,80))
group_all <- bind_rows(group1,group2)
group_all

#### 실습 ####
# --- --- --- --- --- --- --- --- ---
install.packages("ggplot2")
library(ggplot2)

str(ggplot2::mpg)
head(ggplot2::mpg,10)
class(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg)
mpg
class(mpg)

head(mpg)
tail(mpg)
names(mpg)
dim(mpg)
str(mpg)
View(mpg)

# 배기량(displ)이 4이하인 차량의 모델명, 배기량 , 생산년도 조회
select(filter(mpg, displ <=4), model, displ, year)
mpg_a <- mpg %>% filter(displ <= 4) %>% select (model,displ,year)

# 통합연비 파생변수(tatal)를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 조회 
# 통합 연비 : total <-(cty + hwy)/2
mpg <- mpg %>% mutate(total = (cty+hwy)/2) %>% arrange(desc(total)) %>% head(3)

# 회사별로 "suv"차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 조회
mpg %>% group_by(manufacturer) %>% filter(class == "suv") %>% 
  mutate(total = (cty+hwy)/2) %>% summarise(mean_total=mean(total)) %>%
  arrange(desc(mean_total)) %>% head(5)

# 어떤 회사의 hwy연비가 가장 높은지를 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 조회
mpg %>% group_by(manufacturer) %>% summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% head(3)

# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 경차 차종 수를 내림차순으로 조회 
mpg %>% filter(class == 'compact') %>% group_by(manufacturer) %>%
  summarise(count = n()) %>% arrange(desc(count))

# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터셋과 병합하여 출력
# c:CNG =2.35 , d: Disel=2.38, e:Ethanol =2.11, p: Premium = 2.76, r: Regular= 2.22
# unique(mpg%fl)
fuel <- data.frame(fl = c("p","r","e","d","c"), price =c(2.76,2.22,2.11,2.38,2.35))
mpg <- left_join(mpg,fuel,by="fl")
head(mpg)

# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름의 파생변수를 생성, 이 때 기준은 20으로 한다.
mpg <- mpg %>% mutate(total = (cty+hwy)/2)
mpg$test <- ifelse(mpg$total>20,"pass","fail")
head(mpg$test)

# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?
table(mpg$test)

# 통합 연비등급을 A,B,C,세 등급으로 나누는 파생변수 추가 : grade 
# 30이상이면 A, 20~29는 B,20미만이면 c등급으로 분류
mpg$grade <- ifelse(mpg$total >= 30,"A", ifelse(mpg$total >=20 ,"B","C"))
table(mpg$grade)
head(mpg)

# --- --- --- --- --- --- --- --- ---
# 미국 동북부 437개 지역의 인구 통계 정보
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
names(midwest)
str(midwest)

# 전체 인구대비 미성년 인구 백분율(ratio_child)변수를 추가
midwest <- midwest %>% mutate(ratio_child = (poptotal-popadults) / poptotal * 100) 
midwest$ratio_child
# 미성년 인구 백분율이 가장 높은 상위 5개 지역의 미성년 인구 백분율을 출력
midwest %>% group_by(county) %>% arrange(desc(ratio_child)) %>% head(5)

# 븐류표의 기준에 따라 미성년 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 조회
# 분류표 : 미성년 인구 백분율이 40이상이면 'large', 30이상이면 'middle', 그렇지않으면 'small'
midwest$grade <- ifelse(midwest$ratio_child >= 40,"Large",ifelse(midwest$ratio_child >=30,"middle","small"))
midwest$grade                     
                     
# 전체 인구 대비 아시아인 인구 백분율(ratio_asian)변수를 추가하고 하위 10개 지역의 state, county, 아시아인 인구 백분율을 출력
midwest %>% mutate(ratio_asian = popasian/ poptotal * 100) %>% arrange(ratio_asian) %>% 
  select(state, county, ratio_asian) %>% head(10)


#### Data Preprocessing ####
# 순서 : 데이터 탐색 > 결측치 처리 > 이상치 처리 > Feature Engineering 

# 데이터 탐색
#   1) 변수 확인
#   2) 변수 유형 : 범주형, 연속형, 문자형, 숫자형, ...
#   3) 변수의 통계량 : 평균, 최빈값, 중간값, 분포, ...
#   4) 관계, 차이 검정 

# 결측치 처리
#   1) 삭제 
#   2) 다른값으로 대체 (평균, 최빈값, 중간값)
#   3) 예측값 : 선형 회귀분석, 로지스틱 회귀분석

# 이상치 처리
#   1) 이상치 탐색 : 
#       - 시각적 확인 : 산포도, box plot
#       - 통계적 확인 : 표준 잔차, leverage, Cook's D
#   2) 처리 방법
#       - 삭제 
#       - 다른값으로 대체 
#       - 리샘플링(케이스별로 분리) : 표본을 다시 뽑음

# Feature Engineering
#   1) Scaling   : 단위 변경
#   2) binning   : 연속형 변수를 범부형 변수로 변환
#   3) Transform : 기존 존재하는 변수의 성질을 이용해 다른 변수를 만드는 방법(파생 변수 생성)
#   4) Dummy     : 범주형 변수를 연속형 변수로 변환

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# 변수명 변경
df_raw <-data.frame(var1 =c(1,2,3),var2 = c(2,3,2))
df_raw

# 내장함수 사용
df_new1 <- df_raw
names(df_new1) <- c('v1','v2')
df_new1

# 패키지 사용 (dplyr)
df_new2 <-df_raw
df_new2 <- rename(df_new2, v1=var1,v2=var2)
df_new2

#### 결측치 처리 ####
dataset1 <- read.csv('../data/dataset.csv',header = T)
head(dataset1)
View(dataset1)
str(dataset1)

# resident : 1~5까지의 값을 갖는 명목변수로 거주지를 나타낸다
# gender : 1~2 까지의 ㄱ밧을 갖는 명목변수, 남/녀를 나타냄
# job : 1~3까지의 값을 갖는 명목변수, 직업을 나타냄
# age : 양적변수(비율) : 2~69
# position : 1~5까지의 값을 갖는 명목변수, 직위를 나타냄
# price : 양적변수(비율): 2.1~7.9
# survey : 1~5까지의 값을 갖는 명목변수수, 만족도 조사  

y <- dataset1$price
plot(y)

attach(dataset1)
price
#detach(dataset1)
#price

# 결측치 확인
summary(price)

# 결측치 제거 
sum(price, na.rm =T)
price2 <- na.omit(price)  
summary(price2)
sum(price2)

# 결측치 대체 
# 0으로 대체 
price2 <- ifelse(!is.na(price),price,0)
sum(price2)
# 평균으로 대체
price2 <- ifelse(!is.na(price), price, round(mean(price, na.rm = T), 2))
sum(price2)

### 이상치 처리 ####

# 질적 자료
detach(dataset1)
table(dataset1$gender)
dataset1
pie(dataset1$gender)
                 
# 양적 자료 
summary(dataset1$price)   # 평균이 8.752 MAX,MIN 값이 675,-457.3로 이상치가 존재한다
length(dataset1$price)    # 전체의 개수 : 300 결측치 제외

plot(dataset1$price)
boxplot(dataset1$price)

dataset2 <- subset(dataset1, price >=2 & price <=8) # subset으로 이상치 제거 가능
length(dataset2$price)    # 251 개로 이상치가 제거됨
plot(dataset2$price)
boxplot(dataset2$price)

summary(dataset2$age)     # 항상 이 세가지를 통해서 데이터를 먼저 분석하자
plot(dataset2$age)
boxplot(dataset2$age)

#### Feature Engineering ####
View(dataset2)

# 가독성을 위한(기술 통계)를 위한 데이터 변경
dataset2$resident2[dataset2$resident == 1] <- "1.서울특별시"
dataset2$resident2[dataset2$resident == 2] <- "1.인천광역시"
dataset2$resident2[dataset2$resident == 3] <- "3.대전광역시"
dataset2$resident2[dataset2$resident == 4] <- "4.대구광역시"
dataset2$resident2[dataset2$resident == 5] <- "5.시구군"

View(dataset2)

# 척도 변경 : Binning
# 나이 변수를 청년층(30세 이하), 중년층(31~55이하), 장년층(56~)
dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age >= 31 & dataset2$age <= 55] <- "중년층"
dataset2$age2[dataset2$age >= 56] <- "장년층"

View(dataset2)

# 역코딩  : 원래 가지고 있던 값들의 의미를 반대로 바꾸는 것
table(dataset2$survey) # 데이터 파악 
# 가장 간단한 방법 : 최대값 - 값
survey <- dataset2$survey
survey
csurvey <- 6 - survey
dataset2$survey <- csurvey
head(dataset2)

# Dummy
# 거주 유형 : 단독주택(1), 다가구주택(2), 아파트(3), 오피스텔(4)
# 직업 유형 : 자영업(1), 사무직(2), 서비스(3), 전문직(4), 기타
user_data <- read.csv("../data/user_data.csv",header = T)
View(user_data)

table(user_data$house_type)

house_type2 <- ifelse(user_data$house_type == 1 | user_data$house_type == 2, 0,1)
user_data$house_type2 <- house_type2
head(user_data,10)

# 데이터의 구조 변경(wide type, long type) : melt(wide > long), cast(long> wide)
# package : reshape, reshape2, tidyr, ...
install.packages("reshape2")
library(reshape2)

str(airquality)
head(airquality) # wide 형 

m1 <- melt(airquality,id.vars = c("Month","Day"))
View(m1)

m2 <- melt(airquality, id.vars = c("Month","Day"), variable.name = "climate_var", value.name="climate_val")
head(m2)

dc1 <- dcast(m2,Month + Day ~ climate_var)
head(dc1)

data <- read.csv("../data/data.csv")
data # long

wide <- dcast(data, Customer_ID ~ Date)
wide

wide1 <- dcast(data, Customer_ID ~ Date, sum)
wide1

long <- melt(wide, id.vars = "Customer_ID")
long

pay_data <- read.csv("../data/pay_data.csv")
View(pay_data)
head(pay_data)
# product_type을  wide하게 변환
product_price <- dcast(pay_data, user_id ~ product_type,mean)
View(product_price)

# --- --- --- --- --- --- --- --- --- --- --- --- ---

#### MySQL 연동 ####
install.packages("rJava")
install.packages("DBI")
install.packages("RMySQL")

library(RMySQL)

# create database rtest;

# create table score (
#   student_no varchar(50) primary key,
#   kor int default 0,
#   eng int default 0,
#   mat int default 0
# );

# insert into score(student_no, kor, eng, mat) values('1', 90, 80, 70);
# insert into score(student_no, kor, eng, mat) values('2', 90, 88, 70);
# insert into score(student_no, kor, eng, mat) values('3', 90, 89, 70);
# insert into score(student_no, kor, eng, mat) values('4', 90, 87, 70);
# insert into score(student_no, kor, eng, mat) values('5', 90, 60, 70);

# DB 접속  dbConnect()
conn <- dbConnect(MySQL(),dbname='rtest',user='root',password='1111',host='127.0.0.1')
conn

# Table 목록
dbListTables(conn)

# 쿼리문 작성
result <- dbGetQuery(conn,"Select count(*) from score")
result

result <- dbGetQuery(conn,"Select * from score")
result

# field 조회
dbListFields(conn,"score")

# DML
dbSendQuery(conn,"delete from score")

result <- dbGetQuery(conn,"Select * From score")
result

# 파일로 부터 데이터를 읽어들여 DB에 저장
file_socre <- read.csv('../data/score.csv', header = T)
head(file_socre)

dbSendQuery(conn,"drop table score")
dbListConnections(conn)

dbWriteTable(conn,"score",file_socre, row.names=F)

result <- dbGetQuery(conn,"Select * from score")
result

# DB 접속 종료
dbDisconnect()

# --- --- --- --- --- --- --- --- --- --- --- --- ---

#### sqldf : R + SQL ####
install.packages("sqldf")

library(sqldf)

detach("package:RMySQL",unload = T)

head(iris)
sqldf("select * from iris limit 6")
sqldf("select * from iris order by Species desc limit 10")
sqldf('select sum("Sepal.Length") from iris')   # .은 sql에서 사용불가하기 때문에 ""로 .이 포함된 변수를 묶어준다.

unique(iris$Species)
sqldf("Select distinct species from iris")

table(iris$Species)
sqldf("select distinct species,count(*) from iris group by species")

 




