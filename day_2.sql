USE `employees`;

SELECT * FROM departments;
/*
1. departments테이블에 레코드를 등록해 주세요.
dept_no : d010
dept_name : Busivess
*/

INSERT INTO departments
(dept_no, dept_name)
VALUES 
('d010', 'Business');

SELECT * FROM employees;

SELECT * FROM employees
WHERE emp_no = 500000;

INSERT INTO employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES 
(500000, '1999-10-10', 'Gildong', 'Hong', 'M', '2022-03-29');
-- 날짜의 디폴트 값은 값이 없을시 그날 날짜로 지정됨

SELECT * FROM employees
WHERE gender = 'F'
and last_name like '%ch%';

SELECT * FROM employees
WHERE birth_date LIKE '____-0_-__';
-- 언더바를 통해서 채우기 가능

/*함수 사용 위치 찾기*/
SELECT * from employees
WHERE LEFT(birth_date, 4) = '1952';
-- 왼쪽에서 4번째를 찾음

SELECT * from employees
WHERE LEFT(birth_date, 4) >= '1960';

SELECT birth_date, right(birth_date, 2), MID(birth_date, 6, 2)
from employees;

UPDATE employees
SET gender = 'F',
hire_date = '2021-03-29',
first_name = 'Jindong'
WHERE emp_no = 500000;

/*DELETE FROM employees
WHERE LEFT(hire_date, 4) >= '2020';*/

SELECT emp_no AS my_no FROM employees
WHERE LEFT(hire_date, 4) >= '2020';
-- 별칭(AS)은 테이블에서는 안바뀐다 as없이 'my_no'도 가능

/*
 서브쿼리
 emp_no = 499613인 근로자와 생년월일과 같은 사람을 찾자
 */

SELECT birth_date FROM employees
WHERE emp_no = 499613;

SELECT * FROM employees
WHERE birth_date = '1953-06-09';
-- 위아래 같은 값이지만 아래는 하나의 단서를 통해 값을 찾은 것
SELECT * FROM employees
WHERE birth_date = (SELECT birth_date FROM employees WHERE emp_no = 499613);
-- 합친 값

/* emp_no: 499619 */
SELECT gender FROM employees
WHERE emp_no = 499619;
-- 스칼라 값(행도 열도 하나인 것)
-- where절에서  = 과 서브쿼리를 사용 할 때는 스칼라 값을 하나만 써야한다
-- <=, >= 등도 상황에 맞춰 사용
SELECT * FROM employees
WHERE gender = (SELECT gender FROM employees WHERE emp_no = 499619)
AND emp_no != 499619;

SELECT * FROM salaries
WHERE salary >= ANY (SELECT salary FROM salaries WHERE emp_no = 10010);
-- some과any는 동일하다
-- any는 최소값 all은 최대값 기준
SELECT * FROM salaries
WHERE salary >= All (SELECT salary FROM salaries WHERE emp_no = 10010);
-- 스칼렛 값을 쓸때는 any, all을쓰지만 in을쓰는게 낫다
SELECT * FROM salaries
WHERE salary IN (SELECT salary FROM salaries WHERE emp_no = 10010);

SELECT salary FROM salaries
WHERE emp_no = 10010;

/*
오름차순(위에서 아래로 값이 커진다) asc
내림차순(위에서 아래로 값이 작아진다) desc
*/
SELECT * FROM salaries
WHERE emp_no IN (499988, 499987, 499986)
ORDER BY emp_no DESC, from_date;
-- 같은 열의 값이라도 정렬 순서를 바꿀수있다 / 순서는 DB에서 딱히 중요하지 않다

SELECT * FROM employees
ORDER BY birth_date DESC, gender DESC;

