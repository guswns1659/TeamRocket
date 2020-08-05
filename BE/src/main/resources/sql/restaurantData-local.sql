use anglehack;
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/home/jack/Downloads/anglehack/jejurestaurant.csv'
     INTO TABLE anglehack.restaurant FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
     (@var1, @var2, @var3, @var4, @var5, @var6)
     SET id = @var1, address = @var2, description = @var3, name = @var4, point = ST_GeomFromText(@var5, 0), rating = @var6;

LOAD DATA LOCAL INFILE '/home/jack/Downloads/anglehack/foodimage.csv'
     INTO TABLE anglehack.restaurant_image FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
     (@var1, @var2)
     SET restaurant_id = @var1, image_url = @var2;
