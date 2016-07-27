HW3: Due Feb 17, midnight
For each question, I list the problem and the expected answers (remember that the order of rows and columns might be different in some cases).

For each question, list your confidence level on a scale of 0 - 10, with 0 indicating lowest level of confidence and 10 indicating the highest level of confidence.

Grading. Qns 1 - 4: 0.5 pt each. Qns 5 - 12. 1 pt each.

Qn 1. List all products (ProductKey and ProductName) that are available for a ListPrice < 100

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       445 Men's Sports Shorts, S                             
       453 Men's Sports Shorts, M                             
       454 Men's Sports Shorts, L                             
       455 Men's Sports Shorts, XL                            
       474 Women's Mountain Shorts, S                         
       475 Women's Mountain Shorts, M                         
       476 Women's Mountain Shorts, L                         
       488 Short-Sleeve Classic Jersey, S                     
       489 Short-Sleeve Classic Jersey, M                     
       490 Short-Sleeve Classic Jersey, L                     
       491 Short-Sleeve Classic Jersey, XL   

Qn 2. List all products (ProductKey and ProductName) that are available for a ListPrice < 100 and available in Black color (Color = 'Black')

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       445 Men's Sports Shorts, S                             
       453 Men's Sports Shorts, M                             
       454 Men's Sports Shorts, L                             
       455 Men's Sports Shorts, XL                            
       474 Women's Mountain Shorts, S                         
       475 Women's Mountain Shorts, M                         
       476 Women's Mountain Shorts, L   

Qn 3. Do the same as Qn 2, but rename the result columns to PKey and PName. Also order the result rows by ListPrice.

      PKEY PNAME                                            
---------- --------------------------------------------------
       445 Men's Sports Shorts, S                             
       453 Men's Sports Shorts, M                             
       454 Men's Sports Shorts, L                             
       455 Men's Sports Shorts, XL                            
       474 Women's Mountain Shorts, S                         
       475 Women's Mountain Shorts, M                         
       476 Women's Mountain Shorts, L 

Qn 4. List all products (ProductKey and ProductName) that are mountain bikes (ProductSubcategoryName = 'Mountain Bikes'). Also order the results by ProductSize.

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       344 Mountain-100 Silver, 38                            
       348 Mountain-100 Black, 38                             
       345 Mountain-100 Silver, 42                            
       349 Mountain-100 Black, 42                             
       350 Mountain-100 Black, 44                             
       346 Mountain-100 Silver, 44                            
       351 Mountain-100 Black, 48                             
       347 Mountain-100 Silver, 48  

Qn 5. List all products (ProductKey and ProductName) that are bikes (ProductCategoryName = 'Bikes'). Also order the results by ProductSize.

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       348 Mountain-100 Black, 38                             
       344 Mountain-100 Silver, 38                            
       580 Road-350-W Yellow, 40                              
       581 Road-350-W Yellow, 42                              
       349 Mountain-100 Black, 42                             
       345 Mountain-100 Silver, 42                            
       346 Mountain-100 Silver, 44                            
       350 Mountain-100 Black, 44                             
       604 Road-750 Black, 44                                 
       582 Road-350-W Yellow, 44                              
       583 Road-350-W Yellow, 48                              
       347 Mountain-100 Silver, 48                            
       351 Mountain-100 Black, 48                             
       605 Road-750 Black, 48                                 
       606 Road-750 Black, 52  

Qn 6. List all products (ProductKey and ProductName) that have been sold in United States (SalesTerritoryCounty = 'United States'). Remove duplicates, and order by ProductKey

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       344 Mountain-100 Silver, 38                            
       345 Mountain-100 Silver, 42                            
       346 Mountain-100 Silver, 44                            
       350 Mountain-100 Black, 44                             
       351 Mountain-100 Black, 48                             
       474 Women's Mountain Shorts, S                         
       475 Women's Mountain Shorts, M                         
       476 Women's Mountain Shorts, L                         
       489 Short-Sleeve Classic Jersey, M                     
       490 Short-Sleeve Classic Jersey, L                     
       491 Short-Sleeve Classic Jersey, XL                    
       580 Road-350-W Yellow, 40                              
       581 Road-350-W Yellow, 42  

Qn 7. List the cheapest product(s) (ProductKey and ProductName of the product(s) with the least ListPrice).

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       489 Short-Sleeve Classic Jersey, M                     
       490 Short-Sleeve Classic Jersey, L                     
       488 Short-Sleeve Classic Jersey, S                     
       491 Short-Sleeve Classic Jersey, XL   

Qn 8. Find the countries (SalesTerritoryCountry) where the cheapest product(s) (products with the least ListPrice) have been sold.

SALESTERRITORYCOUNTRY                            
--------------------------------------------------
United Kingdom                                     
United States                                      
France                                             
Australia                                          
Canada                                             

Qn 9. For each country, list the name of the country and the total number of products sold (i.e., sum of OrderQuantity), 
total dollar amount of sales (sum of OrderQuantity * UnitPrice), and the average dollar amount for each item sold (i.e. total dollar amount of sales/total number of products sold)
for that country. Also order the rows by the average dollar amount for each item. Rename columns as appropriate.

SALESTERRITORYCOUNTRY                                NUMITEMS TOTALSALESAMOUNT   AVGPRICE
-------------------------------------------------- ---------- ---------------- ----------
Canada                                                     10           8924.9     892.49 
United States                                              27         31511.73     1167.1 
France                                                      7         10370.93    1481.56 
Australia                                                  38         62066.62    1633.33 
United Kingdom                                              6         10309.94    1718.32 
Germany                                                     3          6801.97    2267.32 

Qn 10. Find the products (ProductKey and ProductName) that were sold in United States (SalesTerritoryCountry = 'United States') but not in Canada (SalesTerritoryCountry = 'Canada')

PRODUCTKEY PRODUCTNAME                                      
---------- --------------------------------------------------
       344 Mountain-100 Silver, 38                            
       345 Mountain-100 Silver, 42                            
       346 Mountain-100 Silver, 44                            
       350 Mountain-100 Black, 44                             
       489 Short-Sleeve Classic Jersey, M                     
       490 Short-Sleeve Classic Jersey, L                     
       491 Short-Sleeve Classic Jersey, XL                    
       580 Road-350-W Yellow, 40                              

Qn 11. List countries (SalesTerritoryCountry) where at least 20 products were sold (SUM(OrderQuantity) >= 20).

SALESTERRITORYCOUNTRY                            
--------------------------------------------------
United States                                      
Australia                                          

Qn 12. For each country, find the total amount (i.e., SUM(OrderQuantity)) of bikes (ProductCategoryName = 'Bikes') sold in years 2013 and 2014 (OrderDate >= 20130101 AND OrderDate <= 20141231)

SALESTERRITORYCOUNTRY                                NUMITEMS
-------------------------------------------------- ----------
United Kingdom                                              1 
United States                                               4 
France                                                      2 
Germany                                                     2 
Australia                                                   2 
Canada                                                      1 

