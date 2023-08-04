--SELECT(DML 또는 DQL): 조회
/*
 * -데이터를 조회 하면 조건에 맞는 행들이 조회됨.
 * 이때 조회된 행들의 집합을 "RESULT SET"(조회결과의 집합)이라고한다
 * 
 * -RESULT SET 은 0개 이상의 행을포함할수있다
 * 왜0개? 조건에 맞는행이 없을수도잇어서
 */ 

--[작성법]
--SELECT 컬럼명 FROM 테이블명;
-->어떤 테이블의 특정 컬럼을 조회하겠다.


SELECT * FROM EMPLOYEE;
--"*": ALL , 모든, 전부
-->EMPLOYEE테이블의 모든 컬럼(열)을 조회하겠다.


--사번, 직원이름, 휴대전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE ;



------------------------------------------------

--<컬럼 값 산술 연산>
--컬럼값:테이블 내 한칸(==한셀)에작성된 값(DATA)
--EMPLOYEE 테이블에서 모든 사원의 사번,이름 ,급여,연봉 조회

SELECT EMP_ID, EMP_NAME , SALARY, SALARY*12 FROM EMPLOYEE;

SELECT  EMP_NAME + 10 FROM EMPLOYEE;
--ORA-01722: 수치가 부적합합니다
--산술연산은 숫자(NUMBER타입)만가능하다

SELECT EMP_ID +10 FROM EMPLOYEE ;

SELECT '같음'
FROM DUAL 
WHERE 1='1';
-----------------------------------------------


--날짜(DATE) 타입 조회
--EMPLOYEE 테이블에서 이름, 입사일, 오늘날짜 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE FROM EMPLOYEE;

--2023-08-03 12:05:25.000
--SYSDATE: 시스템상의 현재 시간(날짜)를 나타내는 상수


SELECT SYSDATE FROM DUAL;
---DUAL(DUMY TABLE): 가짜테이블(임시조회용 테이블)



--날짜 + 산술연산(+,-)
SELECT SYSDATE -1, SYSDATE , SYSDATE +1 FROM DUAL;
--날짜에 +/- 연산시 일단위로 계산이 진행됨
--SYSDATE: 현재날짜

--------------------------------------------------------
--<컬럼 별칭지정>
/*컬럼명 AS 별칭 : 별칭 띄어쓰기X , 특수문자 X, 문자만 O
 * 
 * 컬럼명 AS "별칭": 별칭 띄어쓰기O , 특수문자 O, 문자만 O
 * 
 * AS생략가능
 * 
 * */
SELECT SYSDATE -1 "하루전",SYSDATE AS 현재시간, SYSDATE +1 내일 FROM DUAL;


----------------------------------------------------

--JAVA 리터럴 : 값 자체를 의미
--DB 리터럴: 임의로 지정한 값을 기존 테이블에 존재하는 값처럼 사용하는것
--(필수)DB의 리터럴 표기법은 ''홀따옴표

SELECT EMP_NAME, SALARY, '원입니다'FROM EMPLOYEE;

-----------------------------------------------------


SELECT *FROM EMPLOYEE;  --EMPLOYEE 의 전체조회


--DISTINCT: 조회 시 컬럼에 포함된 중복 값을 한번만 표기
--주의사항 1) DISTINCT 구문은 SELECT 마다 딱 한번씩만 작성 가능
--주의사항 2) DISTINCT 구문은 SELECT 제일 앞에 작성되어야한다

SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE ;

------------------------------------------


--해석순서: FROM >>>  WHERE 절  >>>SELECT >> ORDER BY
--1. FROM 절:   FROM테이블명
--2. WHERE 절(조건절): WHERE 컬럼명 연산자값
--3.SELECT 절 : SELECT 컬럼명
--4. ORDER BY 컬럼명|별칭|컬럼순서 [ASC|DESC][NULLS FIRST|LAST]

--EMPLOYEE 테이블에서 급여가 3백만원 초과인 사원의
--사번,이름,급여,부서코드 조회

SELECT EMP_ID ,EMP_NAME , SALARY ,DEPT_CODE 
FROM EMPLOYEE
WHERE SALARY >3000000;


--비교 연산자: >,<,>=,<=, =(같다), <>(같지않다)  
--대입연산자:  :=

--EMPLOYEE 테이블에서 부서코드가 'D9'인 사원의
--사번,이름,부서코드, 직급코드를 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, EMP_NO
FROM EMPLOYEE 
WHERE DEPT_CODE='D9';


----------------------------------------
-- 논리 연산자 (AND, OR)
--EMPLOYEE 테이블에서 급여가 300만 또는 500만 이상인 사원의
--사번,이름,급여 , 전화번호조회

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY <3000000 OR SALARY >=5000000;

--EMPLOYEE 테이블에서 급여가 300만 이상 500만 미만인 사원의
----사번,이름,급여 , 전화번호조회

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY >3000000 AND  SALARY <5000000;


--BETWEEN A AND B: A이상 B이하
--300만이상, 600만이하
SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY BETWEEN  3000000 AND 6000000;

--NOT연산자사용가능
SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN  3000000 AND 6000000;


--날짜(DATE)에 BETWEEN 이용하기
--EMPLOYEE 테이블에서 입사일이 1990-0101~1999-12-31사이인 직원의
--이름,입사일 조회

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01'AND '1999-12-31';

--------------------------------------------------------

--LIKE: ~처럼, ~같이
--비교하려는 값이 특정한 패턴을 만족시키면 조회하는 연산자

--[작성법]
--WHERE 컬럼명 LIKE '패턴니 적용된 값'

--LIKE의 패턴을 나타내는 문자(와일드카드)
--'%': 포함
--'_': 글자수

--%예시
--'A%' : A로 시작하는 문자열
--'%A' : A로 끝나는 문자열
--'%A%': A를 포함하는 문자열

--'_'예시
--'A_': A로 시작하는 두글자 문자열
--'____A': A로끝나는 다섯글자 문자열  (_은4개임..)
--'__A__': 세번째 문자가 A인 다섯글자 문자열
--'_____': 다섯글자 문자열(_는 다섯개..)




--EMPLOYEE 테이블에서 성이 '전'씨인 사원의 사번,이름조회

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE 
WHERE EMP_NAME LIKE '전%';




--EMPLOYEE 테이블에서 전화번호가  010 으로 시작하지 않는 사원
--사번,이름, 전화번호 조회

SELECT EMP_ID, EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';





--EMPLOYEE 테이블에서 EMAIL의 _앞에 글자가 세글자인 사원만 조회
--이름 , 이메일조회

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME LIKE '___%';

--ESCAPE
--ESCAPE문자 뒤에 작성된 _ 는 일반문자로 탈출한다는 뜻
--#,^

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';
--WHERE EMAIL LIKE '___^_%' ESCAPE '^';


------------------------------------------------
--연습문제
--EMPLOYEE 테이블에서
--이메일'_' 앞이 4글자이면서
--부서코드가 'D9'또는 'D6'이고-> AND가 OR보다 우선순위가 높다, ()사용가능
--입사일이 1990-01-01~2000-12-31이고
--급여가 270만 이상인 사원의
--사번,이름,이메일, 부서코드, 입사일 , 급여조회

SELECT EMP_ID, EMP_NAME, EMAIL, DEPT_CODE , HIRE_DATE , SALARY 
FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%'ESCAPE '#' 
AND (DEPT_CODE='D9'OR DEPT_CODE='D6')
AND HIRE_DATE BETWEEN '1990-01-01'AND '1999-12-31' 
AND SALARY>=2700000 ;


---연산자 우선순위
/*1.산술연산자(+ - *,/)
 *2.연결연산자(||)
 *3.비교연산자 ()
 *4. IS NULL/ IS NOT NULL, LIKE, IN/ NOT IN
 *5.BETWEEN AND / NOT BETEWEEN AND
 *6.NOT
 *7.AND
 *8.OR
 * */ 

---------------------------------
/*IN 연산자
 * 비교하려는 값과 목록에 작성된 값중
 * 일치하는것이 잇으면 조회한는 연산자
 * 
 *[작성법]
 *WHERE 컬럼명 IN(값1,값2..)
 *WHERE 컬럼명 ='값1'
 *	OR 컬럼명 ='값2'
 *  OR 컬럼명 ='값3';
 * */

--EMPLOYEE 테이블에서
--부서코드가 D1,D6,D9인 사원의
--사번,이름, 부서코드 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1','D6','D9');


--NOT IN
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1','D6','D9')--12명
OR DEPT_CODE IS NULL; --부서코드없는 2명 포함14명

--IS NULL
--IS NOT NULL
-------------------------------------------

/*NULL 처리 연산자
 * 
 * JAVA에서 NULL : 참조하는 객체가 없음을 의미하는값
 * DB에서   NULL : 컬럼에 값이 없음을 의미한는값
 * 
 * 1)IS NULL: NULL 인경우조회
 * 2)IS NOT NULL: NULL이아닌경우
 * 
 * */

--EMPLOYEE 테이블에서 보너스가 있는 사원의 이름,보너스 조회
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL; 

--EMPLOYEE 테이블에서 보너스가 없는 사원의 이름 , 보너스 조회
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;  



-------------------------------------------------

/*ORDER BY 절
 * SELECT문의 조회결과(RESULT SET)를 정렬할때 사용하는 구문
 * 
 * SELECT 문 해석시 가장 마지막에 해석된다.
 * 
 *
 *1 FROM절
 *2 WHERE절
 *3 SELECT절
 *4 ORDER BY 컬럼명 | 별칭 |컬럼순서
 * 
 * */

--EMPLOYEE 테이블 급여 오름차순서.
--사번,이름, 급여조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY;  --ASC가 기본값[ASC|DESC]

--급여 200만 이상인 사원의
--사번,이름,급여 조회
--단 ,급여 내림차순조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >=2000000
ORDER BY 3 DESC;


--입사일 순서대로 이름,입사일 조회(별칭사용)
SELECT EMP_NAME 이름, HIRE_DATE 입사일
FROM EMPLOYEE
ORDER BY 입사일;

/*정렬 중첩: 대분류 정렬후 소분류 정렬*/
--부서코드 오름차순 정렬후 급여 내림차순 정렬
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE ,SALARY DESC;

