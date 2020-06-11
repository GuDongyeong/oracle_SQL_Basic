-- to_number 문자 -> 숫자

SELECT
    '123.67' "1",
    to_number('123.67') "2",
    to_number('123.67', '99999.99') "3", -- 형식은 가용능력에 관련, 공간을 만들어서 채우는 게 아니기 때문에 빈공간 생성되지 않음
--    to_number('123.67', '99999.9') "4", -- 가용능력 이상의 수를 넣으면 에러
    to_number('123.67', '99999.99999') "5"
FROM dual;


SELECT 
    67890+11111 "1",
    '67890' + 11111 "2", -- 숫자로 자동형변환
    to_number('67890') + 11111 "3",
--    '67,890'+11111 "4" -- "invalid number" 에러, 숫자가 아닙니다. , 때문!
--    to_number('67,890')+11111 "5" -- 이것도 에러, 자동형변환 가능한 숫자를 꺼내는 것이기 떄문에
    to_number('67,890', '999,999')+11111 "6" -- 이떄 서식문자 필요
FROM dual;

SELECT 
--    '$78,789'+10000 "1",
    to_number('$78,789', '$999,999,999') + 10000 "2"
FROM dual;


-- to_date  문자 -> 날짜

SELECT
--    '19/10/7' + 5 "1", -- 날짜에 +를 하면 일자에 +됨
    to_date('19/10/7') + 30 "2"    
FROM dual;


SELECT
    '12 1 11' "1",
    to_date('12 1 11') "2", -- 년월일
    to_date('12 1 11', 'YY MM DD') "3", -- 년월일
    to_date('12 1 11', 'MM DD YY') "4" -- 월일년
FROM dual;


-- NVL
SELECT * FROM emp;

SELECT empno, ename, NVL(comm, 0) comm
FROM emp
ORDER BY comm DESC, ename; -- 이미 NULL을 0으로 바꾸어 놓았기 때문에 NULLS LAST를 사용할 필요가 없다

-- NVL2
-- comm이 NULL이면 sal로 치환
-- comm이 NULL이 아니면 sal + comm 으로 치환

-- NULL 데이터는 존재하지 않는 데이터로 생각해서 연산, 함수의 데이터 등으로 사용하면 아무것도 수행하지 않는다
SELECT
    ename, sal, comm, sal + comm -- null값을 연산하면 null값이 나옴, 존재하지 않는 값이 되어버린다
FROM emp;

SELECT 
    ename, NVL2(comm, sal+comm, sal) pay
FROM emp;


-- NULLIF
SELECT
    NULLIF(10, 20) "1",
    NULLIF(20, 10) "2",
    NULLIF(10, 10) "3"
FROM dual;

-- job컬럼에서 'SALESMAN'을 찾는다 -> NULL 변환
-- NULL값을 NVL을 이용해 '영업' 변환
SELECT empno, ename, job
FROM emp;

SELECT empno, ename, job,
    NULLIF(job, 'SALESMAN') N_IF,
    NVL(NULLIF(job, 'SALESMAN'), '영업')
FROM emp;

-- DECODE
SELECT * FROM dept;

SELECT empno, ename, deptno,
    DECODE( deptno,
        10, '회계팀',
        20, '연구팀',
        30, '영업팀',
        40, '운영팀',
        '부서없음' ) dname
FROM emp;


-- CASE 구문
SELECT empno, ename, deptno,
    CASE deptno
        WHEN 10 THEN '회계팀'
        WHEN 20 THEN '연구팀'
        WHEN 30 THEN '영업팀'
        WHEN 40 THEN '운영팀'
        ELSE '부서없음'
    END dname
FROM emp;

SELECT empno, ename, deptno,
    CASE
        WHEN job=upper('president') THEN '사장' -- 위에 있을 수록 우선적으로 수행
        WHEN deptno=10 THEN '회계팀'
        WHEN deptno=20 THEN '연구팀'
        WHEN deptno=30 THEN '영업팀'
        WHEN deptno=40 THEN '운영팀'
        ELSE '부서없음'
    END dname
FROM emp;



-- COUNT
SELECT * FROM emp;
SELECT count(*) cnt FROM emp;

SELECT empno FROM emp;
SELECT count(empno) cnt_empno FROM emp;

SELECT mgr FROM emp;
SELECT count(mgr) FROM emp; -- null값은 없는 값으로 취급되므로 11

SELECT comm FROM emp ORDER BY comm;
SELECT count(comm) FROM emp;

SELECT * FROM emp;
SELECT 'Apple' FROM emp;
SELECT count(*) FROM emp; -- 이거 사용하면 됨
SELECT count(1) FROM emp; -- 더 빠르지 않을까? 전체를 읽을 필요없이 1만읽으면 되니까.. 하지만 같은 성능임! 개선되었음

-- SUM
SELECT sum(sal) tot_sal FROM emp;

-- AVG
SELECT round(avg(sal),2) avg_sal FROM emp;

-- MAX
SELECT max(sal) max_sal FROM emp;


-- MIN
SELECT min(sal) min_sal FROM emp;

SELECT max(ename) FROM emp; -- 사전 순서상 가장 뒤에 오는 값
SELECT min(ename) FROM emp; -- 사전 순서상 가장 앞에 오는 값

SELECT
    max(hiredate), --날짜는 큰 값이 최근값
    min(hiredate) -- 작은 값이 과거
FROM emp;

SELECT * FROM emp
ORDER BY deptno;

-- 전체 sal에 대한 합계
SELECT sum(sal) FROM emp;

-- 부서별 급여 합계
SELECT
    deptno,
    sum(sal)
FROM emp
GROUP BY deptno -- 칼럼명 기준으로 같은 값의 데이터들을 결합해놓은 것
ORDER BY deptno;


-- 부서별 인원수
SELECT
    deptno,
    count(*) cnt
FROM emp
GROUP BY deptno;

SELECT
    deptno,
    job
FROM emp
ORDER BY deptno, job;

-- 부서별+직무별 사원 수
SELECT
    deptno,
    job,
    count(*) cnt
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job;

-- 문법적으로 그룹함수를 제외한 모든 컬럼이 GROUP BY 절에 들어가야 한다, 그러나 의미없는 코드
SELECT
    deptno,
    job,
    ename,
    count(*) cnt
FROM emp
GROUP BY deptno, job, ename
ORDER BY deptno, job;

-- 조회 컬럼
-- deptno, dname, cnt, tot_sal, avg_sal

-- dname -> 한글로
-- cnt, tot_sal, avg_sal -> 부서별 통계
-- avg_sal -> 소수점 2자리까지
SELECT * FROM dept;

SELECT
    deptno,
    DECODE( deptno,
            10, '회계팀',
            20, '연구팀',
            30, '영업팀',
            40, '운영팀',
            '부서 없음') dname,
    count(*) cnt,
    sum(sal) tot_sal,
    round(avg(sal),2) avg_sal
FROM emp
GROUP BY deptno,
        DECODE( deptno,
            10, '회계팀',
            20, '연구팀',
            30, '영업팀',
            40, '운영팀',
            '부서 없음')
ORDER BY deptno;

-- where 절에는 그룹함수를 사용할 수 없다
SELECT
    deptno,
    round(avg(sal),2) avg_sal
FROM emp
--WHERE avg(sal) > 2000 
GROUP BY deptno
HAVING avg(sal) > 2000
ORDER BY deptno;

-- JOIN
SELECT * FROM emp
WHERE empno = 7369;

SELECT * FROM dept
WHERE deptno = 20;



SELECT * FROM emp, dept
WHERE emp.deptno = dept.deptno;


-- 두 테이블의 모든 정보 결합하기, 모든 경우의 수
SELECT * FROM emp, dept;

-- JOIN
--  emp : 8cols 12rows
--  dept : 3cols 4rows
--  emp x dept : 11cols(8+3) 48rows(12x4)

-- emp, dept 테이블 둘 모두에서 deptno 값이 같은 행만 추출
SELECT * FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno -- 조인 조건, 의미있는 데이터를 꺼내오는 조건, 등가 조인
    AND empno >7800; -- 일반 조회 조건, 나중에 적기

-- 테이블 이름에 Alias 적용
SELECT empno, ename, E.deptno, dname
FROM emp E, dept D
WHERE E.deptno = D.deptno -- 조인 조건, 의미있는 데이터를 꺼내오는 조건, 등가 조인
    AND empno >7800; -- 일반 조회 조건, 나중에 적기

-- ANSI INNER JOIN
SELECT empno, ename, E.deptno, dname
FROM emp E
INNER JOIN dept D
    ON E.deptno = D.deptno-- 조인 조건
WHERE empno >7800; -- 일반 조건


-- NON-EQUI JOIN, 비등가 조인
SELECT * FROM emp; -- 사원 정보
SELECT * FROM salgrade; -- 급여등급 정보

SELECT ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal -- 조인 조건 
ORDER BY grade, sal, ename;

-- ANSI 표준 구문
SELECT ename, sal, grade
FROM emp
INNER JOIN salgrade
    ON sal BETWEEN losal AND hisal -- 조인 조건 
--WHERE grade = 3
ORDER BY grade, sal, ename;


-- SELF JOIN
SELECT * FROM emp EMPLOYEE;
SELECT * FROM emp MANAGER;

SELECT empno, ename, mgr FROM emp EMPLOYEE;
SELECT DISTINCT mgr FROM emp MANAGER;

SELECT
    E.empno, E.ename, E.mgr, M.empno, M.ename
FROM emp E, emp M
WHERE E.mgr = M.empno; -- 조인 조건


-- ANSI
SELECT
    E.empno, E.ename, E.mgr, M.ename mname
FROM emp E
INNER JOIN emp M
    ON E.mgr = M.empno; -- 조인 조건
