-- JOINS
-- 1
select * from invoice
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where unit_price > 0.99;

-- 2
select invoice_date, first_name, last_name, total
from invoice
join customer on invoice.customer_id = customer.customer_id;

-- 3
select c.first_name, c.last_name, r.first_name, r.last_name
from customer c
join employee r on c.support_rep_id = r.employee_id;


-- 4
select title, name
from album
join artist on artist.artist_id = album.artist_id;

--5
select track_id
from playlist_track pt
join playlist p on pt.playlist_id = p.playlist_id
where p.name = 'Music';

-- 6
select name
from track
join playlist_track pt on track.track_id = pt.track_id
where pt.playlist_id = 5;

-- 7
select t.name as track, p.name as playlist
from track t
join playlist_track pt on t.track_id = pt.track_id
join playlist p on pt.playlist_id = p.playlist_id
group by track, playlist;

-- 8
select track.name as track, album.title as album
from track 
join album on track.album_id = album.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = 'Alternative & Punk';

-- BD
select track.name as track, genre.name as genre, album.title as album, artist.name as artist
from track
join album on track.album_id = album.album_id
join genre on track.genre_id = genre.genre_id
join artist on album.artist_id = artist.artist_id
join playlist_track pt on track.track_id = pt.track_id
join playlist on pt.playlist_id = playlist.playlist_id
where playlist.name = 'Music';


-- NESTED QUERIES

-- 1
select * 
from invoice
where invoice_id in (
  select invoice_id
  from invoice_line
  where unit_price > 0.99);

--  2 double nested?!
select name
from track
where track_id in (
  select track_id
  from playlist_track
  where playlist_id in (
    select playlist_id
    from playlist
    where name = 'Music'
    )
  );

-- 3
select name
from track
where track_id in (
  select track_id
  from playlist_track
  where playlist_id = 5
  )

-- 4
select *
from track
where genre_id in (
  select genre_id
  from genre
  where name = 'Comedy'
  );

--  5
select *
from track
where album_id in (
  select album_id
  from album
  where title = 'Fireball'
  );

-- 6
select *
from track
where album_id in (
  select album_id
  from album
  where artist_id in (
    select artist_id
    from artist
    where name = 'Queen'
    )
  );

-- UPDATING ROWS

-- 1
update customer
set fax = null;

-- 2
update customer
set company = 'Self'
where company is null;

-- 3
update customer
set last_name = 'Thompson'
where first_name = 'Julia'
and last_name = 'Barnett';

-- 4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

-- 5
update track
set composer = 'The darkness around us'
where composer is null
and genre_id in (
  select genre_id
  from genre
  where name = 'Metal'
  );


--GROUP BY

--1
select count(track_id), genre.name
from track
join genre on track.genre_id = genre.genre_id
group by genre.name;

--2
select count(track_id), genre.name
from track
join genre on track.genre_id = genre.genre_id
where genre.name = 'Pop'
or genre.name = 'Rock'
group by genre.name;

--3
select artist.name as artist, count(album.album_id) as Number
from artist
join album on artist.artist_id = album.artist_id
group by artist.name;


--DISTINCT

--1
select distinct composer
from track;

--2
select distinct billing_postal_code
from invoice;

--3
select distinct company
from customer;

--DELETE ROW
 
--1
delete from practice_delete
where type = 'bronze';

--2
delete from practice_delete
where type = 'silver';

--3
delete from practice_delete
where value = 150;


--eCommerce simulation
create table users (
    user_id serial primary key,
  	user_name varchar(100),
  	user_email varchar(100)
  );

create table product (
    product_id serial primary key,
    name varchar(100),
    price float(15)
    );

create table orders (
    order_id serial primary key,
    product_id int references product(product_id),
    quantity int
  );

insert into users (user_name, user_email)
values
('Jeff', 'Jeff@jeff.jeff'),
('Arnold', 'arnold@arnold.arnold'),
('Gertrude', 'gertrude@gertrude.gertrude');

insert into product (name, price)
values
('squatty potty', 10),
('dental floss', 3.50),
('laptop', 500);

insert into orders (product_id)
values
(1, 10),
(2 12),
(3, 2);

select *
from product
join orders on product.product_id = orders.product_id;

select * from orders;

select sum(price)
from product
join orders on product.product_id = orders.product_id
group by orders.order_id;

alter table orders
add user_id int references users(user_id);

update orders
set user_id = 1
where order_id = 2;
update orders
set user_id = 2
where order_id = 3;
update orders
set user_id = 3
where order_id = 1;

select *
from orders
where user_id = 1;

select count(order_id), user_id
from orders
group by user_id;

