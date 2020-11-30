library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
mpg

# 배기량(displ)이 4이하인 차량의 모델명, 배기량 , 생산년도 조회
mpg %>% filter(displ <= 4) %>% select(model,displ,year)

# 통합연비 파생변수(tatal)를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 조회 
# 통합 연비 : total <-(cty + hwy)/2
mpg %>% mutate(total = (cty+hwy)/2) %>% arrange(desc(total)) %>% head(3)

# 회사별로 "suv"차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 조회
mpg %>% group_by(manufacturer) %>% filter(class =='suv') %>% mutate(total=(cty+hwy)/2) %>% summarise(total_mean = mean(total)) %>% arrange(desc(total_mean)) %>% head(5)

# 어떤 회사의 hwy연비가 가장 높은지를 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 조회
mpg %>% group_by(manufacturer) %>% summarise(hwy_mean=mean(hwy)) %>% arrange(desc(hwy_mean)) %>% head(3)

# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 경차 차종 수를 내림차순으로 조회 
mpg %>% filter(class =='compact') %>% group_by(manufacturer) %>% summarise(count =n()) %>% arrange(desc(count))

# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터셋과 병합하여 출력
# c:CNG =2.35 , d: Disel=2.38, e:Ethanol =2.11, p: Premium = 2.76, r: Regular= 2.22
# unique(mpg%fl)
fuel <- data.frame(fl=c('c','d','e','p','r'),price=c(2.35,2.38,2.11,2.76,2.22))
mpg <- left_join(mpg,fuel, by= "fl")
head(mpg)

# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름의 파생변수를 생성, 이 때 기준은 20으로 한다.
mpg$total <- (mpg$cty+mpg$hwy)/2
mpg$test <- ifelse(total >=20, "pass", "fail")

# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?
table(mpg$test)

# 통합 연비등급을 A,B,C,세 등급으로 나누는 파생변수 추가 : grade 
# 30이상이면 A, 20~29는 B,20미만이면 c등급으로 분류
mpg <- mpg %>% mutate(grade = ifelse(total >=30,'A',ifelse(total >=20, "B","C")))
head(mpg)

# 미국 동북부 437개 지역의 인구 통계 정보
midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
names(midwest)
str(midwest)

# 전체 인구대비 미성년 인구 백분율(ratio_child)변수를 추가
midwest <- midwest %>% mutate(ratio_child = (poptotal-popadults)/poptotal * 100)

# 미성년 인구 백분율이 가장 높은 상위 5개 지역의 미성년 인구 백분율을 출력
midwest %>% group_by(county) %>% arrange(desc(ratio_child)) %>% select(ratio_child) %>% head(5)

# 븐류표의 기준에 따라 미성년 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 조회
# 분류표 : 미성년 인구 백분율이 40이상이면 'large', 30이상이면 'middle', 그렇지않으면 'small'
midwest <- midwest %>% mutate(grade = ifelse(ratio_child >= 40,"large",ifelse(ratio_child >=30,"middle","small")))
midwest$grade

# 전체 인구 대비 아시아인 인구 백분율(ratio_asian)변수를 추가하고 하위 10개 지역의 state, county, 아시아인 인구 백분율을 출력
midwest %>% mutate(ratio_asian = popasian / poptotal * 100) %>% arrange(ratio_asian) %>% select(state, county, ratio_asian) %>% head(10)

# 어떤 회사에서 생산한 'suv' 차종의 도시 연비가 높은지 알아보려고 한다."suv"차종을 대상으로 평균 cty가 가장 높은 회사 다섯곳을 막대 그래프로 출력( 막대는 연비가 높은 순으로 정렬)
suv_df <- mpg %>% group_by(manufacturer)  %>% filter(class == 'suv') %>% summarise(mean_cty = mean(cty)) %>% arrange(desc(mean_cty)) %>% head(5)
suv_df
ggplot(data = suv_df, aes(reorder(manufacturer, -mean_cty), mean_cty)) + geom_col()

