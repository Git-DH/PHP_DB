DROP TABLE t_member_hobbit;

CREATE TABLE t_member_hobbit(
memberid CHAR(8) NOT NULL,
hobbit_id INT(10) UNSIGNED NOT NULL,
PRIMARY KEY (memberid, hobbit_id),
FOREIGN KEY (memberid) REFERENCES membertbl(memberID),
FOREIGN KEY (hobbit_id) REFERENCES t_hobbit_2(hobbit_id)
);
-- primary key는 여러개 줄 때는 따로 넣어야 한다--
-- fk가 걸린건 테이블 정보 보는 곳에서 확인 가능하다
-- fk가 걸린 테이블은 안지워 진다 / 풀고 지우면 다시 걸어줘야함 / gui에서 삭제됨
SELECT * FROM t_member_hobbit;

INSERT INTO t_member_hobbit(memberid, hobbit_id) VALUES('1', 1);
INSERT INTO t_member_hobbit(memberid, hobbit_id) VALUES('1', 2);
INSERT INTO t_member_hobbit(memberid, hobbit_id) VALUES('5', 3), ('5', 7), ('5', 8);
INSERT INTO t_member_hobbit(memberid, hobbit_id) VALUES('7', 6);


/*
테이블 조인하기
select * from 테이블(조인걸) 별명 /  기준이 되는 테이블
inner join테이블명(조인받을) 별명
on 조인걸 별명.컬럼명 = 조인받을 별명.컬럼명; 
순서는 상관 없지만 기준점을 잘 잡자
*/
SELECT B. *, A.*, C.* 
	FROM t_member_hobbit A
INNER JOIN membertbl B
	 ON A.memberid = B. memberID
INNER JOIN t_hobbit_2 C
	 ON A.hobbit_id = C.hobbit_id;


USE `employees`;

SELECT A.emp_no, A.first_name, A.last_name, B.title, D.dept_name
FROM employees A
INNER JOIN titles B
ON A.emp_no = B.emp_no
INNER JOIN dept_emp C
ON B.emp_no = C.emp_no
INNER JOIN departments D
ON C.dept_no = D.dept_no;


SELECT B.gender, AVG(A.salary) 'avg_salary'
FROM salaries A
INNER JOIN employees B
ON A.emp_no = B.emp_no
GROUP BY B.gender;

SELECT A.emp_no, A.first_name, A.last_name, B.salary
FROM employees A
INNER JOIN salaries B
ON A. emp_no = B.emp_no
WHERE A.emp_no = 10001;

-- 부서별 가장 높은 개인 평균 연봉 값;

-- 개인마다 평균 연봉 구함 > 개인을 부서로 조인 > 부서별로 그룹 묶음  > 가장 높은 평균연봉 값
SELECT z.dept_no, MAX(Z.avg_salary) AS max_salary
FROM (
	SELECT B.dept_no, A.emp_no, AVG(A.salary) AS avg_salary
	FROM salaries A
	INNER JOIN dept_emp B
	ON A.emp_no = B.emp_no
	GROUP BY B.emp_no
) Z
GROUP BY Z.dept_no;


SELECT x.dept_name, MAX(Z.avg_salary) AS max_salary
FROM (
        SELECT B.dept_no, A.emp_no, AVG(A.salary) AS avg_salary 
        FROM salaries A
        INNER JOIN dept_emp B
        ON A.emp_no = B.emp_no
        GROUP BY A.emp_no
) Z
INNER JOIN departments X
ON z.dept_no = x.dept_no
GROUP BY x.dept_name
ORDER BY max_salary desc;



-- 부서별 부서이름, 연봉 평균값, max값, min값 나오게 해주세요.
SELECT B.dept_no, C.dept_name , AVG(A.salary), MAX(A.salary), MIN(A.salary)
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY B.dept_no; 

-- 전체 개인 평균 연봉 중에서 가장 높은 연봉 받는 사람의 부서 찾아내는거

SELECT A.emp_no, AVG(A.salary), C.dept_name
FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY A.emp_no
ORDER BY AVG(A.salary) DESC
LIMIT 1;


	 