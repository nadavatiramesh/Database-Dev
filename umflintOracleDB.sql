--q1
SELECT Productkey, Productname
FROM Product
WHERE Listprice<100;

---my confidence level for q1 is 10/10

--q2
SELECT Productkey, productname
FROM product
WHERE LISTPRICE<100 AND COLOR='Black';

---my confidence level for q2 is 10/10

--q3
SELECT Productkey as PKey, productname as PName
FROM product
WHERE listprice<100 AND COLOR='Black'
ORDER By LISTPRICE;

---my confidence level for q3 is 10/10

---q4
SELECT Productkey, productname
FROM product p,productsubcategory ps
WHERE ps.PRODUCTSUBCATEGORYKEY = p.PRODUCTSUBCATEGORYKEY and ps.PRODUCTSUBCATEGORYNAME = 'Mountain Bikes'
ORDER BY Productsize;

---my confidence level for q4 is 10/10

-----Q5
SELECT productkey, productname
FROM product p,productsubcategory ps,productcategory pc
WHERE ps.PRODUCTCATEGORYKEY = pc.PRODUCTCATEGORYKEY and pc.PRODUCTCATEGORYNAME = 'Bikes' and p.PRODUCTSUBCATEGORYKEY = ps.PRODUCTSUBCATEGORYKEY
ORDER BY Productsize;

---my confidence level for q5 is 10/10

----q6
SELECT DISTINCT p.productkey,productname
FROM product p,salesterritory st,internetsales ins
WHERE st.SALESTERRITORYCOUNTRY='United States' and st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY and ins.PRODUCTKEY=p.PRODUCTKEY
ORDER BY Productkey;

---my confidence level for q6 is 10/10

--q7
SELECT Productkey, productname
FROM product
where listprice =
(select min(listprice) from product);

---my confidence level for q7 is 10/10

---q8

SELECT DISTINCT st.SALESTERRITORYCOUNTRY
FROM product p,salesterritory st,internetsales ins
WHERE  st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY and ins.PRODUCTKEY=p.PRODUCTKEY and
p.listprice = (select min(listprice) from product);

---my confidence level for q8 is 10/10

----q9

SELECT salesterritorycountry, sum(orderquantity) as numitem,
sum(OrderQuantity * UnitPrice) as totalsalesamount,
ROUND(sum(OrderQuantity * UnitPrice)/(sum(orderquantity)),2) as avgprice 
from SALESTERRITORY st,INTERNETSALES ins
where st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY
group by salesterritorycountry
order by avgprice;

---my confidence level for q9 is 10/10

-----q10

(SELECT p.Productkey, productname
from SALESTERRITORY st,PRODUCT p, INTERNETSALES ins
where SalesTerritoryCountry = 'United States'and st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY and ins.PRODUCTKEY=p.PRODUCTKEY) MINUS 
(select p.productkey, productname  from SALESTERRITORY st, product p, internetsales ins where SalesTerritoryCountry = 'Canada' 
and st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY and ins.PRODUCTKEY=p.PRODUCTKEY);

---my confidence level for q10 is 10/10

----q11

select salesterritorycountry
from salesterritory st, internetsales ins
where st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY
group by SALESTERRITORYCOUNTRY
having (SUM(OrderQuantity) >= 20);

---my confidence level for q11 is 10/10

----q12
select salesterritorycountry, SUM(OrderQuantity) as numitem
from SALESTERRITORY st,PRODUCTCATEGORY pc, internetsales ins, product p, PRODUCTSUBCATEGORY ps
where ProductCategoryName = 'Bikes' and st.SALESTERRITORYKEY=ins.SALESTERRITORYKEY and pc.PRODUCTCATEGORYKEY=ps.PRODUCTCATEGORYKEY and p.PRODUCTSUBCATEGORYKEY=ps.PRODUCTSUBCATEGORYKEY
and p.PRODUCTKEY=ins.PRODUCTKEY and OrderDate >= 20130101 AND OrderDate <= 20141231
GROUP by salesterritorycountry;

---my confidence level for q12 is 10/10
