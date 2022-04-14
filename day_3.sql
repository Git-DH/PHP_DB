-- dept_emp 테이블에서 dept_no 종류가 몇개가 있는지?
SELECT DISTINCT dept_no FROM dept_emp;

-- 사원의 직무가 무엇이 있는지 select 해주시오.
SELECT DISTINCT title 
FROM titles
ORDER BY title;

-- limit ?(인자값) ///// limit ?, ?
-- limit가 가장 밑으로 가야한다 order by 보다 아래에 입력
-- 페이징 처리 할때 사용
SELECT * FROM employees
LIMIT 30;
-- 값을 하나만 주면 처음부터 분석함

SELECT * FROM employees
LIMIT 20, 10;
/*
앞의 인자값이 줄의 번호로 생각
앞의 인자값은 인덱스 뒤에는 숫자 
앞의 값에서 시작 뒤에 값만큼 보여주기
*/ 

SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 3;

SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 4, 6;

-- 테이블 복사 / 잠시 데이터 보관용으로 사용 할 수 있다
-- 제약조건 까지 복사하는 법은 따로 있다
CREATE TABLE departments_temp
(SELECT * FROM departments);
/*
위랑 같음/ 테이블 칼럼, 데이터 타입, 레코드 복사
CREATE TABLE departments_temp AS
SELECT * FROM departments;
*/
CREATE TABLE departments_temp2
LIKE departments;
-- 테이블 스키마 복사 (레코드x)
INSERT INTO departments_temp2 SELECT * FROM departments;
-- like 로 처리한 상태에서 데이터도 입력함 

-- 그룹 함수 min, max, sum, avg, count / 주로 숫자와 관련됨

-- group by를 사용 안 했을 때는 전체에서 값을 가져온다
SELECT MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(emp_no), 
FROM salaries;
-- avg는 null값을 제외 sum() / count(*)는 null값이 들어가서 다를 수 있다

SELECT emp_no, salary
FROM salaries;

SELECT emp_no, MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(*)
FROM salaries
GROUP BY emp_no;
-- 같은 값은 그룹으로 묶음 / 그룹당 그불함수가 적용 됨

-- 부서별 사원 수, 부서별 사원수가 20,000명 이상인 부서만 나오도록 한다
SELECT dept_no, COUNT(*)
FROM dept_emp
GROUP BY dept_no
HAVING COUNT(*) >= 20000
ORDER BY COUNT(*) DESC;

SELECT * FROM employees
WHERE emp_no =(
	SELECT emp_no FROM salaries
	WHERE salary = (SELECT MIN(salary) FROM salaries)
	);

SELECT * FROM employees
WHERE emp_no = (
SELECT emp_no FROM salaries 
ORDER BY salary 
LIMIT 1
);
-- 다시 고민 해보기

USE `test`;

CREATE TABLE t_hobbit(
i_hobbit INT UNSIGNED auto_INCREMENT,
nm VARCHAR(10) UNIQUE NOT NULL,
PRIMARY KEY (i_hobbit)
); 
-- 이부분 깃 허브 확인하기
INSERT INTO t_hobbit(i_hobbit, nm)
VALUES (1, '농구');

INSERT INTO t_hobbit(i_hobbit, nm)
VALUES (2, '축구');

INSERT INTO t_hobbit(i_hobbit, nm)
VALUES (3, '배구');

SELECT *FROM t_hobbit;

CREATE TABLE t_hobbit_2(
hobbit_id INT UNSIGNED PRIMARY KEY,
NAME VARCHAR(20) NOT NULL,
created_at DATETIME default NOW()
);
 INSERT INTO t_hobbit_2
 (hobbit_id, name)
 values
 (1, '핸드볼');
 
 INSERT INTO t_hobbit_2
 (hobbit_id, NAME, created_at)
 values
 (2, '등산', '2022-02-10');
 
 INSERT INTO t_hobbit_2
 (hobbit_id, NAME, created_at)
 values
 (3, '독서', '2022-02-10 12:12:13');
 
 SELECT * FROM t_hobbit;
 SELECT * FROM t_hobbit_2;
 
 INSERT INTO t_hobbit_2
 (hobbit_id, name)
 SELECT i_hobbit+3, nm FROM t_hobbit;
 -- 대량의 샘플데이터 생성
 
 -- emp_no: 10001의 모든 salary에 1000씩 올리고 싶다
 UPDATE salaries
 SET salary = salary + 1000
 WHERE emp_no = 10001;
 
 SELECT * FROM salaries
 WHERE emp_no = 10001;
 
 -- insert ignore : pk 중복이 오더라도 오류를 발생시키지않고 무시하고 넘어간다
 SELECT * FROM t_hobbit_2;
 
 INSERT IGNORE INTO t_hobbit_2(hobbit_id, NAME) VALUES(7, '탁구');
 INSERT IGNORE INTO t_hobbit_2(hobbit_id, NAME) VALUES(8, '스키');
 
 INSERT INTO t_hobbit_2 (hobbit_id, NAME) VALUES(8, '스키')
 ON DUPLICATE KEY UPDATE NAME = '수영';
 /*
 ON DUPLICATE KEY UPDATE
 데이터 삽입 시, PRIMERY KEY나 UNIQUE KEY가 중복되었을 경우 
 지정한 데이터만 UPDATE하는 명령어
 */
 DROP TABLE t_board;
 CREATE TABLE t_board(
 i_board INT UNSIGNED PRIMARY KEY,
 title VARCHAR(20) UNIQUE NOT NULL,
 hits INT UNSIGNED DEFAULT 0
 );
 
 SELECT * FROM t_board;
 
 INSERT INTO t_board (i_board, title, hits) VALUES (2, '안녕', 0)
 ON DUPLICATE KEY UPDATE hits = hits + 1;
 
 
 
 
 -- with 비재귀 사용은 잘 안하는거 같다
 WITH dept_emp_d001(emp_no, from_date, to_date)
 AS (
 SELECT emp_no, from_date, to_date 
 FROM dept_emp
 WHERE dept_no = 'd001'
 )
 SELECT * FROM dept_emp_d001;
 -- 서브쿼리로 가능하다
 SELECT A. * from
 (
 SELECT emp_no, from_date, to_date 
 FROM dept_emp
 WHERE dept_no = 'd001'
 )A;
/* 
A는 임시테이블에 별명을 줌
select 가 끝나야만 결과가 나오는게 있어서 where 절을 쓰기 위해
서브쿼리로 묶어서 결과를 내고 where절을 이어서 사용
 */
 
 DROP TABLE t_order;
 CREATE TABLE T_ORDER(
 o_no INT UNSIGNED PRIMARY KEY,
 cus_no INT UNSIGNED,
 o_date DATE DEFAULT NOW(),
 o_price INT DEFAULT 0,
 FOREIGN KEY (cus_no) REFERENCES t_customer(cus_no)
 );
 -- foreign key는 서로 형식이 같아야 한다(INT UNSIGNED=INT UNSIGNED)
 -- 깃허브 봐야함
 SELECT * FROM t_order;
 
 INSERT INTO t_order
 (o_no, cus_no, o_price)
 values
 (1, 3, 55000),
 (2, 5, 70000),
 (3, 3, 60000);
 
 
 DELETE FROM t_order
 WHERE o_no = 2;
 

 DROP TABLE T_CUSTOMER;
 CREATE TABLE T_CUSTOMER(
 cus_no INT UNSIGNED PRIMARY KEY,
 nm VARCHAR(10) NOT NULL
 ); 
 
 INSERT INTO T_CUSTOMER
 (cus_no, nm)
 values
 (3, '홍길동'),
 (5, '이순신');
 
 update t_customer
 SET nm = '장보고'
 WHERE cus_no = 5;
 
 SELECT o_no, o_price FROM t_order
 WHERE cus_no = 3;
 
 SELECT * FROM T_CUSTOMER;
 
 
 
 