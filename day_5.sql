-- 형변환
-- convert(강제 형 변환)
SELECT '10';
SELECT CONVERT('10',INT);

SELECT '10' + '10';
SELECT CONVERT('10', INT) + CONVERT('10',INT);

SELECT CONVERT('10.1', FLOAT);
SELECT CONVERT(10.1, FLOAT);

SELECT 10;
SELECT CONVERT(10, CHAR);

-- 형변환 cast
SELECT CAST('10' AS INT);

SELECT 4 > '2mega';

-- 문자열 합치기 concat
SELECT 'A1' + '2B2';
SELECT CONCAT('A1', '2B2');
SELECT CONCAT('A1', '2B2', '가나다');

-- IF (조건식, 참, 거짓) 결과에 따라서 참, 거짓이 나온다
SELECT if(100>200, '100은 200보다 크다', '100은 200보다 작다');

USE `employees`;

SELECT gender, if (gender = 'M', '남자', '여자')
FROM employees; 

-- 응용
SELECT 'M', 'F', 'A';

SELECT if('A'='M', '남자', if('A' = 'F', '여자', '외계인'));

SELECT 'M';
SELECT 'F';
SELECT 'A';

-- 응용2

SELECT nm, if(nm ='농구','basketball', if(nm = '배구', 'valleyball', 'football'))
FROM t_hobbit;

SELECT if(nm ='농구',
			CONCAT(nm,'basketball'), 
			if(nm = '배구', 
			  CONCAT(nm, 'valleyball'),
 			  CONCAT(nm,'football')
			  )
			)
FROM t_hobbit;


-- if null (오라클 : nvl, SQL=Server : isnull)

SELECT *, IFNULL(memberaddress, '주소없음')
FROM membertbl;


-- nullif 컬럼 값이 같으면 null로 뜨고 다른면 첫번째 값니 나온다
SELECT NULLIF('안녕','안녕');
SELECT NULLIF('안녕1','안녕2');


-- case 값 when 비교값 then ...
SELECT
nm,
case nm when '농구' then 'basketball'
			when '배구' then 'valleyball'
			when '축구' then 'football'
	END
FROM t_hobbit;

-- case when 조건식 then ...
-- 비교문을 사용시에는 이 식이 더 낫다
SELECT
	nm,
	case when nm = '농구' then 'basketball'
			when nm = '배구' then 'valleyball'
			when nm = '축구' then 'football'
			ELSE '없음'
	END
FROM t_hobbit;

-- 아스키 코드
SELECT ASCII('A'), CHAR(65);

-- 문자열 합치기 concat, concat_ws
SELECT CONCAT('A','_', 'B','_', 'C');
SELECT CONCAT_WS(',','A','B','C');

-- FORMAT( 천단위 콤마, 실수 몇자리 까지 나타낼지 선택)
SELECT FORMAT(11112222, 0);

-- insert 원하는 문자열위치에 삽입
SELECT 
	INSERT('abcdefghi', 3, 0, '@@@@')
 , INSERT('abcdefghi', 3, 0, '@@@@');
 
-- upper, lower 대, 소문자 변형
SELECT 'abc'
, 'ABC'
, 'aBc' = 'Abc'
, UPPER('aBc')
, UPPER('AbC')
, UPPER('aBc') = UPPER('AbC');


-- trim 양쪽 빈칸을 없애줌 한쪽만 없애려면 L과 R로 쓰면 됨
SELECT '     abc      ', TRIM('     abc      ');

SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋabcㅋㅋㅋ');


-- date_format
SELECT *, DATE_FORMAT(created_at, '%Y/%m/%d %p %h:%i') FROM t_hobbit_2;
