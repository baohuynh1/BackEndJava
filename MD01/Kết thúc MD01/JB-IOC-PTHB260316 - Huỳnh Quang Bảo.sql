--1
create table Customer(

    customer_id varchar(5) primary key ,
    customer_full_name varchar(100) not null ,
    customer_email varchar (100) unique not null ,
    customer_phone varchar(15) not null ,
    customer_address varchar(255)
);
create table  Room (
    room_id varchar(5) primary key ,
    room_type varchar(50) not null,
    room_price decimal(10,2) not null ,
    room_status varchar(20) not null ,
    room_area int not null
);
create table Booking (
    booking_id serial primary key,
    customer_id varchar(5),
    room_id varchar(5),
    check_in_date date,
    check_out_date date,
    total_amount decimal(10,2),
    constraint fk_customer_booking foreign key (customer_id) references Customer(customer_id),
    constraint fk_room_booking foreign key (room_id) references Room(room_id)

);
create table Payment(
    payment_id serial primary key ,
    booking_id int,
    payment_method varchar(50) not null ,
    payment_date date not null ,
    payment_amount decimal(10,2) not null,
    constraint fk_booking_payment foreign key (booking_id) references Booking(booking_id)
);

--2

insert into Customer(customer_id, customer_full_name, customer_email, customer_phone, customer_address)
values ('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', 0912345678, 'Hanoi, Vietnam'),
       ('C002', 'Tran Thi Mai', 'mai.tran@example.com', 0923456789, 'Ho Chi Minh, Vietnam'),
       ('C003', 'Le Minh Hoang', 'hoang.le@example.com', 0934567890, 'Danang, Viet Nam'),
       ('C004', 'Pham Hoang Nam', 'nam.pham@example.com', 09456788901, 'Hue, Vietnam'),
       ('C005', 'Vu Minh Thu', 'thu.vu@example.com', 0956789012, 'Hai Phong, Vietnam'),
       ('C006', 'Nguyen Thi Lan', 'lan.nguyen@example.com', 0967890123, 'Quang Ninh, Vietnam'),
       ('C007', 'Bui Minh Tuan', 'tuan.bui@example.com', 0978901234, 'Bac Giang, Vietnam'),
       ('C008', 'Pham Quang Hieu', 'hieu.pham@example.com', 0989012345, 'Quang Nam, Vietnam'),
       ('C009', 'Le Thi Lan', 'lan.le@example.com', 0990123456, 'Da Lat, Vietnam'),
       ('C010', 'Nguyen Thi Mai', 'mai.nguyen@example.com', 0901234567, 'Can Tho, Vietnam');

insert into Room (room_id, room_type, room_price, room_status, room_area)
values ('R001', 'Single', 100.0, 'Available', 25),
       ('R002', 'Double', 150.0, 'Booked', 40),
       ('R003', 'Suite', 250.0, 'Available', 60),
       ('R004', 'Single', 120.0, 'Booked', 30),
       ('R005', 'Double', 160.0, 'Available', 35);

insert into Booking (booking_id, customer_id, room_id, check_in_date, check_out_date, total_amount)
values (1, 'C001', 'R001', '2025-03-01', '2025-03-05', 400.0),
       (2, 'C002', 'R002', '2025-03-02', '2025-03-06', 600.0),
       (3, 'C003', 'R003', '2025-03-03', '2025-03-07', 1000.0),
       (4, 'C004', 'R004', '2025-03-04', '2025-03-08', 480.0),
       (5, 'C005', 'R005', '2025-03-05', '2023-03-09', 800.0),
       (6, 'C006', 'R001', '2025-03-06', '2025-03-10', 400.0),
       (7, 'C007', 'R002', '2025-03-07', '2025-03-11', 600.0),
       (8, 'C008', 'R003', '2025-03-08', '2025-03-12', 1000.0),
       (9, 'C009', 'R004', '2025-03-09', '2025-03-13', 480.0),
       (10, 'C010', 'R005', '2025-03-10', '2025-03-14', 800);

insert into Payment (payment_id, booking_id, payment_method, payment_date, payment_amount)
values (1, 1, 'Cash', '2025-03-05', 400.0),
       (2, 2, 'Credit Card', '2025-03-06', 600.0),
       (3, 3, 'Bank Transfer', '2025-03-07', 1000.0),
       (4, 4, 'Cash', '2025-03-08', 480.0),
       (5, 5, 'Credit Card', '2025-03-09', 800.0),
       (6, 6, 'Bank Transfer', '2025-03-10', 400.0),
       (7, 7, 'Cash', '2025-03-11', 600.0),
       (8, 8, 'Credit Card', '2025-03-12', 1000.0),
       (9, 9, 'Bank Transfer', '2025-03-13', 480.0),
       (10, 10, 'Cash', '2025-03-14', 800.0);

--3
update booking
set total_amount=r.room_price * (b.check_out_date - b.check_in_date)
from Room r
join booking b on r.room_id = b.room_id
where room_status = 'Booked';

--4
delete from Payment
where payment_method = 'Cash'
and payment.payment_amount < 500.0;

--5
select *
from Customer
order by customer_full_name;

--6
select r.room_id,r.room_type,r.room_price,r.room_area
from Room r
order by r.room_price desc;

--7
select c.customer_id,c.customer_full_name,b.room_id,b.check_in_date,b.check_out_date
from Customer c join booking b on c.customer_id=b.customer_id;

--8
select c.customer_id,c.customer_full_name,p.payment_method,p.payment_amount
from Customer c join Booking b on c.customer_id=b.customer_id
join Payment p on b.booking_id=p.booking_id
order by p.payment_amount desc;

--9
select c.customer_id,c.customer_full_name
from Customer c
order by c.customer_full_name
limit 3 offset 1;

--10
select c.customer_id,c.customer_full_name,count(b.room_id),sum(p.payment_amount)
from Customer c join Booking b on c.customer_id=b.customer_id
join Payment p on b.booking_id=p.booking_id
group by c.customer_id, c.customer_full_name having count(b.room_id)>=2 and sum(p.payment_amount) >1000.0;

--11
select r.room_id, r.room_type,r.room_price,sum(p.payment_amount),count(b.customer_id)
from Room r join Booking b on r.room_id=b.room_id
join Payment p on b.booking_id=p.booking_id
group by  r.room_id,r.room_type,r.room_price having sum(p.payment_amount) <1000.0 and count(b.customer_id) >=3;

--12
select c.customer_id ,c.customer_full_name, b.room_id, sum(p.payment_amount)
from Customer c join Booking b on c.customer_id=b.customer_id
join Payment p on b.booking_id=p.booking_id
group by c.customer_id,c.customer_full_name,b.room_id having sum(p.payment_amount) >1000.0;

--13
select c.customer_id, c.customer_full_name,c.customer_email,c.customer_phone
from Customer c
where c.customer_full_name like '%Minh%'
or c.customer_address like 'Hanoi%'
order by c.customer_full_name;

--14
select r.room_id,r.room_type,r.room_price
from Room r
order by r.room_price desc
limit 5 offset 5;

--15
create view  view_booking_before as
select r.room_id,r.room_type,c.customer_id,c.customer_full_name
from Customer c join Booking b on c.customer_id=b.customer_id
join Room r on b.room_id=r.room_id
where b.check_in_date <'2025-03-10';

--16
create view  view_customer_room as
select c.customer_id,c.customer_full_name,r.room_id,r.room_area
from Customer c join Booking b on c.customer_id=b.customer_id
join Room r on b.room_id=r.room_id
where r.room_area >30;

--17
create or replace function fn_check_insert_booking()
returns trigger as $$
    begin
        --kiểm tra
        if(new.check_in_date >new.check_out_date) then
            raise exception 'Ngày đặt phòng không thể sau ngày trả phòng được !';

        end if;
        return new;
    end;
    $$ language plpgsql;
    --Trigger test
create trigger  check_insert_booking before insert on Booking
for each row
execute function fn_check_insert_booking();
    --test
insert into Booking (customer_id, room_id, check_in_date, check_out_date )
values (1,1,'2026-04-20','2026-04-15')

--18
create or replace function fn_update_room_status_on_booking()
returns trigger as $$
    begin
        update Room
        set room_status='Booked'
        where room_id=new.room_id;
        return new;
    end;
    $$ language plpgsql;
  -- trigger test
create trigger update_room_status_on_booking
after insert on Booking
for each row
execute function fn_update_room_status_on_booking();

--19
create or replace procedure add.customer(
    p_customer_id varchar(5),
    p_customer_full_name varchar(100),
    p_customer_email varchar(100),
    p_customer_phone varchar(15),
    p_customer_address varchar(255)
)
language plpgsql
as $$
    begin
        insert into Customer(customer_id, customer_full_name, customer_email, customer_phone, customer_address) values
          (p_customer_id,p_customer_full_name,p_customer_email,p_customer_phone,p_customer_address);
        raise notice 'Khách hàng với id % đã được thêm!',p_customer_id;
    end;
    $$;

--20
create or replace procedure  add_payment (
    p_booking_id int,
    p_payment_method varchar(50),
    p_payment_amount numeric,
    p_payment_date date
) language plpgsql
as $$
    begin
        --check hợp lệ
        if p_payment_amount <=0 then
            raise exception 'Số tiền thanh toán phải lớn hơn 0';

        end if;
        insert into Payment (booking_id, payment_method, payment_date, payment_amount) values
        (p_booking_id,p_payment_method,p_payment_amount,p_payment_date);
        raise notice 'Đã thêm thanh toán thành công cho đơn id: %', p_booking_id;

    end;
    $$







