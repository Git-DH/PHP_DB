create database board1;

    use board1;
    
		DROP TABLE t_board;
    create table t_board ( 
        i_board int unsigned primary key auto_increment, 
        title varchar(200) not null, 
        ctnt varchar(3000) not null, 
        create_at datetime default now()
    );
    
    SELECT * FROM t_board;
