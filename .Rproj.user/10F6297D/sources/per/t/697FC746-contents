#### 변수 ####    

goods = "냉장고"
goods

# R에서 변수를 사용시 객체형태로 사용하는 것을 권장
goods.name <- '냉장고'
goods.code <- 'ref001'
goods.price <- 600000

goods.name

# 값을 대입할때에는 = 보다는 <-를 권장 -p.47

# 데이터타입 확인
class(goods.name)
class(goods.price)

mode(goods.name)
mode(goods.price)

# 도움말 활용 
help(sum)
?sum
args(sum) # 함수에 필요한 인자들만 보여줌
example(sum)  # 함수의 활용,사례를 보여줌줌

#### 데이터 타입 ####
# -p.45 스칼라~데이터프레임 참고

# 0차원 : 스칼라 
# 1차원 : 벡터
# 2차원 : 행렬(metrics,동일한 자료형(주로 숫자), 
#       : 데이터프레임(여러가지형식)
# 3차원 이상 : 배열(array,동일한 자료형),
#            : 리스트(여러가지형식,파이썬(1차원)과다름)

# 벡터  -p.57
#------------
# 1) 기본 자료 구조
# 2) 1차원 배열
# 3) 인덱스 접근 (1부터 시작)
# 4) 동일한 자료형만 저장
# 5) 벡터 생성 함수 : c(), seq(), rep() ...

# c() : combine
v <- c(1, 2, 3, 4, 5)
mode(v)
class(v)
(v <- c(1, 2, 3, 4, 5)) # 출력
mode(c(1:5))  # 범위지정가능 
class(c(1,2,3,4,"5")) # 다른 문자열도 가능

# seq()
?seq
(seq(from=1, to= 10, by=2)) # Seq(1,10,2)

#rep()
rep(1:3, 3)

# 벡터의 접근
a <- c(1:50)
a[10:45]
a[10:(length(a)-5)]
a[10:length(a)-5] # (10:length(a)) -5   << ()를 잘써야함

b <- c(13,-5,20:23,12,-2:3)
b
b[1]
b[c(2,4)]  # 데이터 2개이상을 지정할때에는 반드시 벡터형식으로 지정해야함
b[c(4,5:8,7)]
b[-1] #첫번째에 있는 것을 제외함 -p.51 
      # 정규표현식의 [^a](:a를 제외하고)와 비슷
b[-2]
b[-c(2,4)]

#집합 연산 -p.62
x <- c(1,3,5,7)
y <- c(3,5)
union(x,y) ; setdiff(x,y) ; interaction(x,y)

#컬럼명 지정
age <- c(30,35,40)
age
names(age) <- c('홍길동','임꺽정','신돌석석')
age

# 특정 변수의 데이터 제거 
# 빗자루는 다지워진다.
age <- NULL # NULL 주소를 지운다    -p.51 NULL과 NA차이 
            # NA : 결측치
age

x <-(1:5)  # ※연속적인 데이터일땐 c()를 생략가능하다
x

# 팩터(factor)
#------------------
# 1) 범주형 데이터 타입
gender <- c('man','women','women','man','man')
gender
class(gender)
#-p.89 타입판별  is(물어보는 함수) , as(바꿔주는 함수)
is.factor(gender)
plot(gender)

ngender <- as.factor(gender)
ngender
class(ngender) # 
mode(ngender)  # 물리적인 데이터 형식
is.factor(ngender)
plot(ngender)  # 그래프로 나타낼 수 있음
table(ngender) # 각각의 데이터 개수를 내타내줌

?factor
ofactor <- factor(gender, levels = c("women","man"),
                  ordered=TRUE) #ordered :정렬
ofactor

#===============================================================
# 기본 자료형
# -----------------------
# numeric, character, factor, logical

# 특수 자료형
#------------------------
# NA, NULL, NaN, Inf
#===============================================================

# Matrix   -p.69
#------------------------
# 1) 행과 열의 2차원 배열
# 2) 동일한 데이터 타입만 저장
# 3) Matrix 생성 함수 : matrix(), rbind(), cbind()

m <- matrix(c(1:5))
m
m <- matrix(c(1:11), nrow=2)
m
m <- matrix(c(1:11), nrow=2, byrow=T)  # byrow:T 행위주, 행부터 채움
m

class(m)
mode(m)

# 행,열을 합쳐서 생성
x1 <- c(3,4,50:52)
x2 <- c(30,5,6:8,7,8)
x1
x2

mr <- rbind(x1,x2) # row를 기준
mr

mc <- cbind(x1,x2)  # column을 기준
mc

#데이터 불러오기 
aws = read.delim("../data/AWS_sample.txt",sep="#")

head(aws)

x1 <- aws[1:3,2:4]
head(x1)

x2 <- aws[9:11,2:4]
head(x2)
class(x2)    # 배열이아닌 데이터프레임이다.
             # 하지만 cbind,rbind 사용가능 
cbind(x1,x2)
rbind(x1,x2) # 2차원으로?
class(cbind(x1,x2))

# matrix 활용
x <- matrix(c(1:9), ncol=3)
x 

length(x);nrow(x);ncol(x);dim(x)

# 컬럼명 지정
colnames(x) <- c('one','two','three')
x
class(x)  # 자료형은 2가지 

?apply
apply(x,1,max) # 열을 기준으로 해서 최대값을 뽑아온다.
apply(x,2,max) # 행
apply(x, 1, mean)
apply(x, 2, mean)

#===============================================================
# data.frame
#------------------------
# 1) DB의 table과 유사
# 2) R에서 가장 많이 사용되는 구조
# 3) 컬럼단위로 서로 다른 데이터 타입 사용 가능
# 4) data.frame 생성 함수 : data.frame(),
#       (외부에서 불러옴) :  read.csv(), read.delim(),read.table()

no <- c(1,2,3)
name <- c("hong","lee","kim")
pay <- c(150, 250, 300)

emp = data.frame(no=no,Name=name,Payment=pay)
emp

# 외부 파일을 이용해서 데이터프레임 생성
getwd() # 현재 workdirectory
setwd('../data')
txtemp = read.table('emp.txt',header = T,sep = " ")
txtemp
class(txtemp)

# csv 파일을 이용해서 데이터프레임 생성
csvemp = read.csv('emp.csv')
csvemp

# 제목을 데이터로 가져옴
csvemp2 = read.csv('emp.csv',header =T, col.names = c("사번","이름","급여"))
csvemp2

csvemp3 = read.csv('emp2.csv',header = F, col.names = c("사번","이름","급여"))
csvemp3

View(csvemp3)

# 접근 
csvemp3$사번
class(csvemp3$사번) # 컬럼명으로 접근 
csvemp3[,1]          # 인덱스로 접근 

#데이터프레임 구조 확인
str(csvemp3)

# 기본 통계량 확인
summary(csvemp3)

# apply()
df <- data.frame(x = c(1:5), y = seq(2,10,2), z =c('a','b','c','d','e'))
df
apply(df[,c(1,2)],2,sum)
apply(df[,c(1,2)],1,sum)

# 데이터의 일부 추출 
x1 <- subset(df, x>=3)
x1
x2 <- subset(df,x>=2 & y<=6)
x2
# 병합   기준이 있을때 cbind,rbind 와는 다름   sql의 join과 유사 
height <-data.frame(id=c(1,2), h=c(180,175))
weight <-data.frame(id=c(1,2), w=c(80,75))
user <-merge(height,weight, by.x="id", by.y="id")

#==============================================================
# array
# 1) 행,열, 면의 3차원 배열 형태의 객체 생성
# 2) array 생성 함수 : array()

v <- c(1:12)
arr <- array(v,c(3,2,3))
arr

arr[,,1]
arr[,,2]
arr[2,2,1] # 5
arr[2,1,2] # 8

#==============================================================
# list
#-------------------------
# 1) key와 value가 한쌍
# 2) python 에서의 dict와 유사 
# 3) list 생성 함수 : list()

x0 <- 1
x1 <- data.frame(var1=c(1,2,3),var2=c("a","b","c"))
x2 <- matrix(c(1:12),ncol=2)
x3 <- array(1:20,dim = c(2,5,2))
# 모든 자료형을 한꺼번엔 묶을 수 있음 
x4 <- list(c1=x0, c2=x1 , c3=x2, c4=x3)
x4

x4$c1
x4$c2

list1 <- list("lee","이순신",95)
list1
list1[[1]]

un <- unlist(list1)
un
class(un)

# apply : lapply(), sapply()
a <- list(c(1:5))
b <- list(c(6:10))
a
b

c <- c(a,b)
c
class(c)

x <- lapply(c,max)
x

y <- sapply(c, max)
y

#================================================================
#### 기타 자료형 및 함수들 ####

# 날짜형 
# ---------------
Sys.Date() # 현재날짜 
Sys.time() # 현재시간 

a <- "20/7/13"
a
class(a)

b <- as.Date(a)
class(b)

c <- as.Date(a,"%y/%m/%d")
c

#문자열 처리 함수 
#----------------

# stringr
install.packages('stringr')
# library('패키지명'), require('패키지명')
library(stringr)

str1 <- '홍길동35이순신45임꺽정25'
str_extract(str1, '\\d{2}')
str_extract_all(str1, '\\d{2}')
class(str_extract_all(str1, '[1-9]{2}'))

str2 <- c('hongkd105leess1002you25TOM400강감찬2005')
# 세 자리 문자만 추출
str_extract_all(str2, '[a-zA-Z가-힣]{3}')
str_extract_all(str2, '[a-zA-Z가-힣]{3,}')
str_extract_all(str2, '[a-zA-Z가-힣]{3,5}')

str_length(str2)
length(str2)

str_locate(str2,"강감찬")
str_c(str2,"유비55")
str2

str3 <- c('hongkd105,leess1002,you25,TOM400,강감찬2005')
str_split(str3,",")

# 기본 함수 
sample = data.frame(c1 = c("abc_sdfsdf","abc_kkdfsfdfd","ccd"),
                    c2 = 1:3)
sample

nchar(sample[1,1])           # 길이 구하는 함수 =length
which(sample[,1] =='ccd')    # sorting
toupper(sample[1,1])
tolower(sample[2,1])
substr(sample[,1],start = 1,stop = 2) # 특정 문자열을 뽑아냄 

# 문자열 분리, 병합
install.packages("splitstackshape")
library(splitstackshape)
cSplit(sample,splitCols = 'c1',sep = '_') # 하나의 컬름을 생성 

paste0(sample[,1],sample[,2]) # 공백없이 연결

paste(sample[,1],sample[,2], sep = "@@")
