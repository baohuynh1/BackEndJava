create table library.book(
    id serial primary key,
    title varchar(50),
    author varchar(50),
    category varchar(10),
    publish_year int,
    price int,
    stock int
);
insert into library.book(id,title,author,category,publish_year,price,stock)
values (1,'Lập trình C cơ bản','Nguyễn Văn Nam','CNTT',2018,95000,20),
       (2,'Học SQL qua ví dụ','Trần Thị Hạnh','CSDL',2020,125000,12),
       (3,'lập trình C cơ bản','Nguyễn Văn Nam','CNTT',2018,95000,20),
       (4,'Phân tích dữ liệu với python','Lê Quốc Bảo','CNTT',2022,180000,Null),
       (5,'Quản trị cơ sở dữ liệu','Nguyễn Thị Minh','CSDL',2021,150000,5),
       (6,'Học máy cho người mới bắt đầu','Nguyễn Văn Nam','AI',2023,220000,8),
       (7,'Khoa học dữ liệu cơ bản', 'Nguyễn Văn Nam','AI', 2023, 220000, Null)
--2--
update library.book
set price = price *1.1
where publish_year >=2021 and price <200000;
--3--
update library.book
set stock = 0
where stock is null;
--4--
select * from library.book
where category in ( 'CNTT','AI')
and price between 100000 and 250000
order by  price desc,title ;
--5--
select * from library.book
 where title ilike '%học%';
--6--
select distinct category from library.book
where publish_year >2020;
--7--
select * from library.book
order by id limit 2 offset 1;




