
-- 데이터 연결 연산자 ||
SELECT 
    ename || ' is ' || job AS EMPLOYEE
FROM emp;

-- ' '로 표현된 문자 안에서 '를 사용하고 싶으면 ''를 사용
SELECT -- SMITH'S job is CLERK
    ename || '''s job is ' || job AS EMPLOYEE
FROM emp;

-- SQL Function

-- 단일 행 함수, Single Row Function
-- length() 길이를 재주는 함수
SELECT ename, length(ename)AS len FROM emp; -- Single Row

-- 조회되는 결과의 행 수를 세주는 그룹함수 count()
SELECT count(*) FROM emp;

-- DUAL테이블, 테스트용으로 연산 수행할 때
SELECT 1 FROM emp;
-- emp테이블을 실제 조회, 첫번째 행을 보고 연산 수행, 다음 행...
SELECT 1 + 2 FROM emp;

SELECT 1 FROM dual;
SELECT 1 + 2 FROM dual;

SELECT 1+2 "FIRST", 6*5 SECOND, 5-7 THIRD FROM dual;

-- SQL Function
-- abs(), Absolute
SELECT abs(-44) FROM dual;
SELECT abs(-5678.1234) FROM dual;
SELECT abs(sal) FROM emp;

-- 숫자 함수 문제
-- 12.523 -> 소수점이하 반올림
SELECT round(12.523) FROM dual;
-- -12.723 -> 소수점이하 반올림
SELECT round(-12.723) FROM dual;
-- 12.567 -> 소수점 3째자리에서 반올림
SELECT round(12.567, 2) FROM dual;
-- 12345 -> 1의 자리에서 반올림
SELECT round(12345, -1) FROM dual;
-- 56789 -> 10의 자리에서 반올림
SELECT round(56789, -2) FROM dual;
-- 12.456 -> 소수점이하 버림
SELECT trunc(12.456) FROM dual;
-- 12.456 -> 소수점 3째자리에서 버림
SELECT trunc(12.456, 2) FROM dual;
-- 12345 -> 1의자리에서 버림
SELECT trunc(12345, -1) FROM dual;
-- 56789 -> 10의자리에서 버림
SELECT trunc(56789, -2) FROM dual;
-- 13을 8로 나눈 나머지
SELECT mod(13, 8) FROM dual;
-- 12.345 올림 -> 13
SELECT ceil(12.345) FROM dual;
-- -12.567 올림 -> -12
SELECT ceil(-12.345) FROM dual;
-- 12.567 내림 -> 12
SELECT floor(12.567) FROM dual;
-- 12.123 내림 -> 12
SELECT floor(12.123) FROM dual;
-- -12.567 내림 -> -13
SELECT floor(-12.567) FROM dual;
-- -12.123 내림 -> -13
SELECT floor(-12.123) FROM dual;
-- 3의 4제곱 -> 81
SELECT power(3, 4) FROM dual;
-- 3의 -1 제곱 -> 0.33333333333
SELECT power(3, -1) FROM dual;
-- 9의 제곱근 -> 3
SELECT sqrt(9) FROM dual;
-- 11의 제곱근 -> 3.3166...
SELECT sqrt(11) FROM dual;


-- 문자 함수

-- length()
SELECT 
    length('Apple') len1,
    length('안녕') len2,
    length('Hello 오라클') len3
FROM dual;

-- lengthb() - 바이트 길이, 한글 인코딩 방법  XE에서는 UTF-8, 한글을 3바이트로 처리, SE에서는 2바이트?
SELECT 
    lengthb('Apple') len1,
    lengthb('안녕') len2,
    lengthb('Hello 오라클') len3
FROM dual;


-- 캐릭터셋(인코딩) 확인
SELECT * FROM nls_database_parameters
WHERE parameter = 'NLS_CHARACTERSET';


-- 문자 함수 문제

-- 'hELlo' 모두 대문자로 변환 -> HELLO
SELECT upper('hELlo') FROM dual;
-- 'hELlo' 모두 소문자로 변환 -> hello
SELECT lower('hELlo') FROM dual;
-- 'hELlo' 이니셜(첫글자) 대문자 -> Hello
SELECT initcap('hELlo hI') FROM dual; -- initial Capital

SELECT * FROM tabs
WHERE table_name = upper('emp');

-- 'Alice Bob'의 문자열 길이 -> 9
SELECT length('Alice Bob') FROM dual;
-- '안녕하세요'의 문자열 길이 -> 5
SELECT length('안녕하세요') FROM dual;
-- 'Alice Bob' 문자열 바이트 수 -> 9
SELECT lengthb('Alice Bob') FROM dual;
-- 'ACE 안녕하세요'문자열 바이트 수 -> 19
-- (오라클은 한글 인코딩을 UTF-8을 기본으로 하며
--  UTF-8은 한글 한글자에 3바이트가 필요하다)
SELECT lengthb('ACE 안녕하세요') FROM dual;

-- 'ABCDEFGHI'에서 'D' 의 위치 -> 4
SELECT instr('ABCDEFGHI', 'D') FROM dual;
-- 'ABCDEFGHI'에서 'DEF'문자열의 위치 ->4
SELECT instr('ABCDEFGHI', 'DEF') FROM dual;
-- 'ABCDEFGHI'에서 'DF'문자열의 위치 -> 0
SELECT instr('ABCDEFGHI', 'DF') FROM dual;
-- '안녕하세요'에서 '하'문자열의 위치 -> 3
SELECT instr('안녕하세요', '하') FROM dual;
SELECT instrb('안녕하세요', '하') FROM dual; -- '하'가 몇번째 바이트에 존재하는가
-- 'ABCABCDDD'에서 'C'문자열의 위치 -> 3
SELECT instr('ABCABCDDD', 'C') FROM dual;
--'Oracle SQL Developer'에서 5번째 인덱스 이후의 문자열로 자르기
SELECT substr('Oracle SQL Developer', 6) FROM dual;
--'Oracle SQL Developer'에서 5번째 인덱스부터 5글자로 자르기
SELECT substr('Oracle SQL Developer', 6, 5) FROM dual;
--'오라클 SQL'에서 2번째 인덱스부터 5글자로 자르기
SELECT substr('오라클 SQL', 3, 5) FROM dual;
SELECT substrb('오라클 SQL', 2, 5) FROM dual; -- 겹치는 바이트는 공백으로 처리
--'안녕하세요오라클'에서 3번째 부터 자르기
SELECT substr('안녕하세요오라클', 3) FROM dual;

-- 패딩, Padding
--  문자를 표현하기 위해서 공간을 확보하고 문자를 채워넣고 빈 공간이 남으면 설정한 문자로 채운다
-- 서식유지하기 위해 사용

-- LEFT PADDING : lpad() -- 오른쪽 정렬
SELECT lpad('SQL', 10) FROM dual;
SELECT lpad(ename, 10) FROM emp;

-- 빈칸 채울 문자
SELECT lpad('SQL', 10, '*') FROM dual;
SELECT lpad(ename, 10, '*') FROM emp;
SELECT lpad(ename, 10, '-_-^') FROM emp;

SELECT lpad('ABCDEFGH', 5) FROM dual;

-- RIGHT PADDING : rpad()
SELECT rpad('SQL', 10, '*') FROM dual;
SELECT rpad('SQL', 10) FROM dual;

-- TRIM
-- 데이터 양 끝단에 있는 ' '(띄어쓰기, 공백)을 제거하는 함수
SELECT '    SQL    ',
    ltrim('    SQL    '),
    rtrim('    SQL    '),
    trim('    SQL    '),
    ltrim(rtrim('    SQL    '))
FROM dual;


-- 날짜 함수, DATETIME

-- 컴퓨터가 가진 현재 날짜
SELECT sysdate FROM dual;

-- 날짜 시간 타입 -> 문자타입(서식 지정)
SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') now
FROM dual;

-- MONTHS_BETWEEN : 개월 수 차이
SELECT 
    months_between('20-01-01', '20-02-01') "A",
    round(months_between('20/02/15', '20/02/01'), 2) "B",
    round(months_between(sysdate, '20/02/01'), 2) "C"
FROM dual;

-- next_day : 지정된 요일이 다가오는 날짜 구하기
SELECT
    next_day(sysdate, '금')
FROM dual;

-- trunc(number) 
-- trunc(datatime) 함수 : 시간을 자정(00:00:00)으로 초기화

SELECT
    sysdate -- 시간이 숨어있음 
FROM dual;

SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') now,
    to_char(trunc( sysdate ), 'YYYY/MM/DD HH24:MI:SS') now
FROM dual;

-- 보이는 결과는 같지만 시간이 포함되어있어 서로 다른 값을 가진다
SELECT
    sysdate,
    trunc(systable)
FROM dual;


-- to_char(number)
-- to_char(number, fmt) : 서식문자를 이용한 변환
SELECT
    12345 "0",
    to_char(12345) "1", -- number -> varchar2 = '12345'
    length(to_char(12345)) "3",
    length(12345) "4", -- 굳이 변환할 필요 없었음, 자동 형변환(대부분 문자, 숫자 사이에서 일어난다)
    to_char(12345, '99') "5", -- 숫자가 차지할 수 있는 최대 길이가 2글자인 문자열 서식 의미
    to_char(12345, '9999999999') "6",
    to_char(12345, '0000000000') "7", -- 9는 남는 공간을 공백으로 0은 0으로 패딩
    to_char(12345, '9990000000') "8"
FROM dual;

SELECT
    to_char(12345.6789) "1",
    to_char(12345.6789, '99999.9') "2", -- 자릿수가 부족하면 반올림하여처리
    to_char(12345.6789, '9,999,999.99') "3", -- 정수부 남는 공간은 빈칸, ,추가
    to_char(12345.6, '9,999,999.9999') "4" -- 정수부 남는 공간은 빈칸, 소수점은 0으로 패딩
FROM dual;

SELECT
    to_char(12345) "1",
    to_char(12345, '$99,999,999') "2",
    to_char(12345, '$999') "3", -- 자릿수 부족하면 #으로 나옴
    trim(to_char(12345, 'L99,999,999')) "4" -- LOCALE : 이미 저장되어있는 값, 언어, 통화, 단위, 타임존 등 환경 정보
FROM dual;

-- to_char(datetime)
SELECT 
--    sysdate
--    to_char(sysdate, 'SCC') -- 세기

--    to_char(to_date('369/1/7'), 'SCC') -- 문자는 날짜로 자동형변환되지 않는 경우가 많으므로 수동으로 해주어야한다

--    to_char(sysdate, 'YEAR'),
--    to_char(sysdate, 'year'),
--    to_char(sysdate, 'Year')
 
--    to_char(sysdate, 'YYYY'),
--    to_char(sysdate, 'YY'),
--    to_char(sysdate, 'YYY'),
--    to_char(sysdate, 'Y'),
--    to_char(sysdate, 'YYYYYY') -- YYYY YY
    
--    to_char(sysdate, 'MM'), -- 숫자 월
--    to_char(sysdate, 'MONTH'), -- 문자 월
--    to_char(sysdate, 'MON') -- 문자 월 약어

--    to_char(sysdate, 'Q') -- 분기

--    to_char(sysdate, 'DD'),-- 월 단위 일수
--    to_char(sysdate, 'D'), -- 주 단위 일수, 요일
--    to_char(sysdate, 'DDD') -- 년 단위 일수

--    to_char(sysdate, 'DAY'), -- 요일   
--    to_char(sysdate, 'DY') -- 요일 약어

--    to_char(sysdate, 'HH'), -- 12시간 기준 시간
--    to_char(sysdate, 'HH12'), --12시간 기준 시간
--    to_char(sysdate, 'HH24') -- 24시간 기준 시간

--    to_char(sysdate, 'MI') -- 분    

--    to_char(sysdate, 'AM'),    
--    to_char(sysdate, 'PM'),    
--    to_char(sysdate, 'A.M'),    
--    to_char(sysdate, 'P.M') 

    to_char(sysdate, 'FF') -- 밀리초    
FROM dual;

SELECT sysdate, systimestamp FROM dual;

SELECT
    to_char(systimestamp, 'FF'),
    to_char(systimestamp, 'FF1'), -- 1/10 초
    to_char(systimestamp, 'FF2'), -- 1/100초
    to_char(systimestamp, 'FF3') -- 1/1000초
FROM dual;

SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS DAY')
FROM dual;

SELECT * FROM emp
--WHERE to_char(hiredate, 'Q') =3; -- 3분기에 입사한 사람들
WHERE hiredate >= '81/07/01' AND hiredate < '81/10/1';

