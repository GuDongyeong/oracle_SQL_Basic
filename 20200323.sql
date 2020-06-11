-- scott/tiger 접속...

-- 사용자 계정의 테이블 조회
-- ( tabs ) 자료사전
SELECT * FROM tabs;

-- 테이블의 구조(스키마) 간단히 확인
DESC emp;

-- 테이블의 데이터 확인
SELECT * FROM emp;

-- 주석, Comment
-- 한줄 주석 단축기 : ctrl + /


-- SELECT 구문

-- 전체 컬럼 조회
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM salgrade;
SELECT * 
FROM bonus;

-- 부분 컬럼(지정한 컬럼) 조회
SELECT
    empno, ename, job 
FROM emp;

-- 조회되는 컬럼명에 별칭(Alias)을 적용하기
SELECT
    empno AS "사번", -- 사원번호, as 보여줄 때만 이름을 바꿔서 보여준다
    ename "이름" -- 사원이름, as 없어도 가능
FROM emp;

desc emp;
select empno, ename, job from emp;


-- WHERE절 (조건절)

-- 영업사원들만 조회하기
SELECT * FROM emp
WHERE job = 'SALESMAN';
-- 숫자, 문자, 날짜 : 문자는 ''로 표시
-- = 동등비교연산자

-- 전체 사원들 중 급여가 2000이 넘는 사원
SELECT * FROM emp
WHERE sal > 2000;

-- 급여가 2500이 넘고 관리자가 아닌 사원
SELECT * FROM emp
WHERE sal > 2500
--    AND job != 'MANAGER';
    AND NOT(job = 'MANAGER');
    
    
    
-- BETWEEN a AND b
-- 사원번호가 7700 ~ 7900인 사원 조회
SELECT empno, ename FROM emp
WHERE empno BETWEEN 7700 AND 7900;

-- 사원 이름이 'ALLEN' ~ 'KING' 사이인 사원 조회, 문자는 사전 순서대로, ASCII CODE값
SELECT empno, ename FROM emp
--WHERE ename BETWEEN 'ALLEN' AND 'KING';

-- 반대 경우
--WHERE NOT(ename BETWEEN 'ALLEN' AND 'KING');
WHERE ename NOT BETWEEN 'ALLEN' AND 'KING';

-- 데이터 자체는 대소문자를 구문하지만 키워드, 칼럼명 등은 대소문자상관없긴하다
-- 문법요소는 대문자, 식별자는 소문자


-- IN(list)
SELECT empno, ename FROM emp
WHERE empno IN ( 7369, 7521, 7654, 7777, 8888, 7878);


-- NOT IN( list )
SELECT empno, ename FROM emp
WHERE empno NOT IN ( 7369, 7521, 7654, 7777, 8888, 7878);
--WHERE NOT(empno IN ( 7369, 7521, 7654, 7777, 8888, 7878));


SELECT empno, ename FROM emp
WHERE ename IN('SMITH', 'ALLEN', 'KING', 'ALICE');


-- LIKE
SELECT empno, ename FROM emp
--WHERE ename LIKE '%R%'; -- 이름에 R을 포함하는 사원
--WHERE ename LIKE '_A%'; -- 이름의 두번째가 A인 사원
--WHERE ename LIKE '%RD'; -- 이름이 RD로 끝나는 사원
WHERE ename NOT LIKE '%R%'; -- 이름에 R을 포함하지 않는 사원

-- 주의사항 : LIKE 연산자와 IN연산자를 같이 사용하는 문법은 없다, 아래처럼 한번 더 써주어야 함
SELECT empno, ename FROM emp
WHERE ename LIKE '%R%'
    OR ename LIKE '%L%';

-- 동등비교할 때는 LIKE쓰지 말 것, 
-- 서식없이 동등비교(equal)를 할 때에는 LIKE연산자를 사용하면 안된다( Full-Scan 발생 )
SELECT empno, ename FROM emp
--WHERE empno LIKE '7654'; -- 무조건 full스캔이 먼저 일어난다, 성능에 악영향
WHERE empno = '7654'; -- 인덱스가 잡혀있는 컬럼이라면 인덱스스캔을 우선 한다


SELECT * FROM emp
--WHERE mgr = NULL; -- NULL값은 아예 없는 값이므로 스캔할 때 NULL값은 조회하지 않는다
WHERE mgr IS NULL;

-- WHERE 절 퀴즈
SELECT * FROM emp;

-- 부서번호가 30이고 직무가 영업
SELECT empno, ename, deptno FROM emp
WHERE deptno = 30 
    AND job = 'SALESMAN';
    
-- 부서번호가 30이고 직무가 영업이 아닌 사원
SELECT empno, ename, deptno FROM emp
WHERE deptno = 30
    AND job != 'SALESMAN';
    
-- 부서번호가 30이 아니고 직무가 영업이 아닌 사원 조회
SELECT empno, ename, deptno FROM emp
WHERE deptno != 30
    AND job != 'SALESMAN';
    
-- 사원번호가 7782에서 7900 사이인 사원 조회
SELECT empno, ename, deptno FROM emp
WHERE empno BETWEEN 7782 AND 7900;

-- 사원명이 A에서 C로 시작하는 사원 조회
SELECT empno, ename, deptno FROM emp
WHERE ename >= 'A'
    AND ename < 'D';
--WHERE ename LIKE 'A%'
--    OR ename LIKE 'B%'
--    OR ename LIKE 'C%'; -- 풀스캔이 될 위험이 많다, 인덱스스캔의 가능성을 줄인다
--WHERE ename < 'D';
--WHERE ename BETWEEN 'A' AND 'C~'; -- ~가 아스키코드값의 마지막 번호

-- %는 LIKE와 쓰일때만 가능하다
    
-- 부서번호가 10 또는 50인 사원 조회(IN사용)
SELECT empno, ename, deptno FROM emp
WHERE deptno IN (10, 30);

--  ORDER BY 절
SELECT * FROM emp
--ORDER BY empno;
ORDER BY ename DESC;

-- 부서번호 오름차순, 부서 내 이름 내림차순, 동명이인 사번 오름차순
SELECT * FROM emp
ORDER BY deptno ASC, ename DESC, empno;

-- NULL값을 가장 큰값으로 취급
SELECT empno, ename, comm FROM emp
ORDER BY comm DESC NULLS LAST; -- NULLS : 널 값에 대한 추가 정리, NULL값을 마지막으로
--ORDER BY comm ASC NULLS FIRST; -- NULL값을 처음으로

SELECT empno, ename, comm, deptno FROM emp
--WHERE comm IS NOT NULL
ORDER BY comm DESC NULLS LAST, ename, empno;

-- 조회되지 않는 컬럼을 이용해서도 정렬기준으로 삼을 수 있다
SELECT empno, ename, comm FROM emp
ORDER BY sal DESC, comm DESC;

-- DISTINCT키워드
SELECT DISTINCT 
    deptno
FROM emp
ORDER BY deptno;

SELECT empno, ename FROM emp;

--같은행 전부가 같은 값을 가지고 있어야 중복으로 처리한다
SELECT DISTINCT empno, ename FROM emp;

SELECT DISTINCT
    deptno, ename
FROM emp
ORDER BY deptno, ename;

SELECT DISTINCT
    job
FROM emp
ORDER BY job;

SELECT DISTINCT
    deptno, job
FROM emp
ORDER BY deptno, job;