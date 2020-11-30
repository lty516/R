#### 키보드 입력 ####
# scan() 
# edit()

# a <- scan  :기본 default가 정수형을 받음
a <- scan()
a
# what = character() : 문자를 입력받기 
b <- scan(what = character()) 
b

df <- data.frame()
df <- edit(df)
df

####파일 입력 #####
# read.csv()
# read.table()
# read.xlsx()

# TSV : Tab
# CSV : ,

student <- read.table("../data/student.txt")
student

student1 <- read.table(file = "../data/student.txt",header=T)
student1

# file.choose() : 파일을 선택해서 가져오기 
student2 <-read.table(file = file.choose(),header = T,sep = ";") 
student2

# na.strings = 결측치를 찾는다 
student3 <-read.table(file.choose(), header = T,sep = "",
                      na.strings = c("-","+","&")) 
student3


# read.xlsx() : java설치 필요
install.packages("xlsx")
library(xlsx)
library(rJava)# 안정적으로 돌리기 위해서 
# sheetIndex = 엑셀 시트 선택
studentx <- read.xlsx(file.choose(),sheetIndex = 1, encoding = 'UTF-8')
studentx

#### 웹 문서 읽기 ####
install.packages('httr')
install.packages('XML')

library(httr)
library(XML)

url <- 'https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015'

get_url <- GET(url)
get_url

html_content <- readHTMLTable(rawToChar(get_url$content)) # rawToChar > 사람이 이해하는 것으로 변환
html_content
class(html_content)
str(html_content)

df <- as.data.frame(html_content)
df

#### 화면 출력 ####
# 변수명
# ()
# cat()
# print()

x <- 10
y <- 20
z <- x + y

z
(z <- x+y)

print(z)
print(z <- x + y)

# print("x+y의 결과는",as.character(z),"입니다.") 연결해서 출력 불가능 
cat("x + y의 결과는",as.character(z),"입니다.") # 연결해서 출력 가능능

#### 파일 출력 ####
# write.table()
# write.csv()

studentx <- read.xlsx(file.choose(),sheetIndex = 1, encoding = 'UTF-8')
studentx
class(studentx)

write.table(studentx,"../data/stud1.txt")
write.table(studentx,"../data/stud2.txt",row.names = F)   # row.names : 인덱스 제거
write.table(studentx,"../data/stud3.txt",row.names = F, quote = F) # quote = F : ""제거 

write.csv(studentx,"../data/stud4.csv",row.names = F, quote = F)

library(rJava)
library(xlsx)

write.xlsx(studentx,"../data/stud5.xlsx")

#### rda 파일 ####
# save()           
# load()

save(studentx,file = "../data/stud6.rda")

rm(studentx) # 메모리를 삭제 
studentx

load("../data/stud6.rda")
studentx

#### sink() ####
data() # 샘플 불러오기
?data

data(iris)
head(iris)
tail(iris)
str(iris)

sink('../data/iris.txt') # 작업 파일출력 

head(iris)
tail(iris)
str(iris)

sink() # 종료

head(iris)