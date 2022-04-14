-- DCL(제어어) (유저 만들고, 유저 권한 주고)
-- 아직 안배울거임!

-- DDL(데이터 정의어)
CREATE DATABASE test;
DROP DATABASE test2;
CREATE DATABASE test4;
DROP DATABASE test4;

CREATE TABLE memberTBL(
	memberID CHAR(8) NOT NULL PRIMARY KEY,
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20) NULL
);

CREATE TABLE memberTBL(
	memberID CHAR(8),
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20) NULL,
	PRIMARY KEY (memberID)
);
-- pk 지정 법 2가지 / 아래는 여러개 줄 때 좋음 
/*
primary key기본 unique, not null, index
*/
/*
*uniqe-겹치면 안됨
*not null-무시할 수 없다 / 값을 비워서는 안됨
*null-기본값이고 빈 값이 들어와도 됨
*/
DROP TABLE membertbl;

CREATE TABLE producttbl(
	productname CHAR(4) PRIMARY KEY,
	cost INT NOT NULL,
	MAKEDATE date,
	company CHAR(5),
	amount INT NOT null
);
-- 정수int, 실수(인트는 정수만 되고 실수는 안됨)
-- signed(int 기본값으로 음수 허용 반대는 unsigned )
-- -5~5(11개), 0~10(11개) 음수가 없는 만큼 양수가 증가
DROP TABLE PRODUCTtbl;

-- crud, dml(데이터 조작어)
-- CREATE(insert문)
/*INSERT into 테이블명
(값을 넣고싶은 컬럼명)
VALUES
(값들);*/

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
('1', '홍길동', '서울시');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
('2', '홍길동', '서울시');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
('3', '홍길동', '서울시');

INSERT INTO membertbl
(memberid, membername)
VALUES
('5', '신사임당'),
('6', '유관순'),
('7', '나이팅게일');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
('8', '사나이', '부산시');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
(9, '사나이', '대구시');
-- read(select문)
/*
select 보고싶은 컬럼명들 from 테이블명
[ join 테이블 연결 ]
[ where 보고싶은 조건 ]
[ group by 그룹으로 묶는 조건 ]
[ having 그룹으로 묶는 조건에서의 조건 ]
[ order by 레코드 순서 지정 ]
[ limit 보고싶은 레코드 수 ]
*/
SELECT memberID, membername, memberaddress FROM membertbl;
SELECT * FROM membertbl;
SELECT memberID, membername FROM membertbl;
SELECT membername FROM membertbl;

SELECT memberid, membername, memberaddress
FROM membertbl;

SELECT * FROM membertbl
WHERE membername='홍길동';

SELECT * FROM membertbl
WHERE memberaddress !='서울시'
OR memberaddress IS null;
-- !는 그거만 제외
SELECT * FROM membertbl
WHERE memberaddress <>'서울시'
OR memberaddress IS NULL;
-- DB에서만 쓰는 제외 표현

SELECT * FROM membertbl
WHERE memberaddress ='부산시'
AND membername = '사나이';
-- and 와 or 구분 잘 하기

SELECT * FROM membertbl
WHERE memberaddress IS NULL;
-- null은 앞에 is룰 적어줘야 한다

SELECT *FROM membertbl
WHERE membername LIKE '%이%';
-- 이가 들어가는 거 다 나옴
SELECT *FROM membertbl
WHERE membername LIKE '나%';
-- 시작부분으로 찾을때
SELECT *FROM membertbl
WHERE membername LIKE '%일';
-- 일로 끝나는 거 찾을때
-- like문은 문자열 포함된 레코드를 찾을 때

-- update(update문)
/*
update 테이블명
set 수정하고 싶은 컬럼명 = 변경하고 싶은 값
where 레코드-이거 없으면 큰일 남
*/
UPDATE membertbl
SET membername = '게일'
WHERE memberid= '7';

UPDATE membertbl
SET membername = 'gugu',
memberaddress= '강원도'
WHERE memberid= '9';

UPDATE membertbl
SET membername = '111',
memberaddress= '222'
WHERE memberid= '0';

-- delete(delete문)
/* delete from 테이블명 where절 */
DELETE FROM membertbl
WHERE memberaddress is NULL;

DELETE FROM membertbl
WHERE memberid = '2';

-- 질문에 대한 답
-- 혹시 where을 1~10 사이에 있는 칼럼중에 서울시만 선택하고 싶다 이렇게 구체적인 것도 되나요?
SELECT * FROM employees
WHERE emp_no >= 10010 AND emp_no <=10020;
-- 일정 범위를 정해서 찾음

SELECT *, CONVERT(memberid, INT), CAST(member AS INT)
FROM test.membertbl;
-- 문자를 숫자로 바꾸는 법

SELECT '1'+'11' AS num;
-- DB에서는 사칙연산만 됨

SELECT CONCAT('1','11');
-- 문자열을 합칠때 사용
SELECT CONCAT('1', CONCAT(' ', CONCAT('11',  '안녕')));
-- 안쪽 괄호부터 처리됨
SELECT CONCAT('1', CONCAT(' ', '11안녕')    );
SELECT CONCAT('1', '11안녕');
SELECT CONCAT('111안녕');
-- Arguments: 괄호안에 함수 값을 보내는 거
SELECT * FROM employees
WHERE emp_no between 10010 AND 10020;
-- between or: 숫자가 외에연속되지 않는 것들의 값을 찾을때 사용
/*
A<B : A는B미만
A<=B : A는 B이하
A>B : A는 B 초과
A>=B : A는 B 이상
*/

SELECT * FROM departments
WHERE dept_no = 'd001' 
or dept_no ='d003' 
or dept_no ='d005';

/*SELECT * FROM departments
WHERE dept_no IN ('d001', 'd003', 'd005');
위의 축약형
*/

SELECT * FROM employees
WHERE emp_no % 2=0;
-- 짝수 홀수 구분 법 
-- %(모드)는 나머지 값이 나옴