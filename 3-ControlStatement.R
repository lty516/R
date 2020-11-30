#### 조건문 ####

# 난수 발생
x <- runif(1) # 0 ~ 1 까지 균일 분포, rnorm:정규분포
x

# x가 0보다 크면 절대값으로 값 출력
if (x>0) {
  print(abs(x))
}

# x가 0.5보다 작으면  1-x를 출력하고 그렇지 않으면 x를 출력
if (x<0.5) {
  print(1-x)
}else{
  print(x)
}
  
# 코드가 한줄인 경우는 {} 생략 가능 
if(x<0.5) print(1-x) else print(x)

# ifelse(): 다수의 True,False데이터를 한번에 처리할때 
ifelse(x<0.5,1-x,x)

# 다중 조건 
avg <- scan()

if (avg >= 90) {
  print("당신의 학점은 A입니다.")  
} else if (avg >= 80) {
  print("당신의 학점은 B입니다.")
} else if (avg >= 70) {
  print("당신의 학점은 C입니다.")
} else if (avg >= 60) {
  print("당신의 학점은 D입니다")
} else {
  print("당신의 학점은 F입니다.")
}

# switch (비교문, 실행문1, 실행문2, 실행문3) 
a <- '중1'
switch (a, "중1" = print("14살"), "중2" = print("15살"))
switch (a, "중1" = "14살", "중2" = "15살") # print 생략 가능 

b <-3
switch (b, "14살", "15살", "16살") # 인덱스 값으로도 활용가능 

empname <- scan(what="")
switch (empname, hong = 250 , lee= 350 , kim = 200, kang = 400)

avg <- scan() %/% 10
switch (as.character(avg) ,"10" ="A","9"= "A","8"="B","7"="C","6"="D","F")
 
# which()  : 특정데이터 검색
x <- c(2:10)
x

which(x == 3)
x[which (x ==3)]

m <- matrix(1:12,3,4)
m

which(m%%3 ==0)
which(m%%3 ==0, arr.ind = F)
which(m%%3 ==0, arr.ind = T)

no <-c(1:5)
name <- c("홍길동","유비","관우","장비","조자룡")
score <- c(85,78,89,90,74)
exam <- data.frame(학번 =no, 이름=name, 점수 = score)
exam

# 이름이 장비인 사람 검색
which(exam$이름 =='장비')
exam[4,]

data("trees")
head(trees)
tail(trees)

# height 컬럼이 70미만인 행의 위치를 검색하고 행을 출력
which(trees$Height < 70)
trees[which(trees$Height < 70), ]

# 최대,소 값 검색
which.max(trees$Height)
which.min(trees$Height)


# any() all()
x <- runif(5)
x

# x중에서 0.8이상이 있는가?
any(x >= 0.8)

# x의 값이 모두 0.9이하인가?
all(x <= 0.9)

#### 반복문 ####
# for
sum <- 0
for (i in seq(1,10,by = 1)) {
  sum <- sum +i
}
sum

for (i in seq(1,10,by = 1)) sum <- sum +i
sum

# 1부터 10까지 짝수값만 출력
for (i in seq(1,10)) {
  if (i %% 2 == 0) 
    print(i)
}

# break : 반복문 종료 , next : 현재 수행중인 반복문 블록의 수행을 중단하고 


#### 함수 ####

# 인자 없는 함수 
test1 <- function(){
  x <- 10
  y <- 10
  return(x * y)
}

# 인자 있는 함수
test2 <- function(x,y){
  xx <- x
  yy <- y
  return(sum(xx * yy))
}

test2(10,20)

# 가변길이 : ...
test3 <- function(...){
#  print(list(...))
  args <- list(...)
  for (i in args) {
    print(i)
  }
}

test3(10)
test3(10,20)
test3(10,20,30)
test3("3","홍길동","7")

test4 <- function(a,b,...){
  print(a)
  print(b)
  print("-------")
  test3(...)
}

test4(10,20,30,40)