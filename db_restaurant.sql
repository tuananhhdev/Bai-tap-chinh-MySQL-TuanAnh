USE db_restaurant;

CREATE TABLE `user` (
  `user_id` INT PRIMARY KEY AUTO_INCREMENT,
  `full_name` VARCHAR(255),
  `email` VARCHAR(255),
  `password` VARCHAR(255)
);




CREATE TABLE `restaurant` (
  `res_id` INT PRIMARY KEY AUTO_INCREMENT,
  `res_name` VARCHAR(255),
  `image` VARCHAR(255),
  `desc` VARCHAR(255)
)


CREATE TABLE `food_type` (
  `type_id` INT PRIMARY KEY AUTO_INCREMENT,
  `type_name` VARCHAR(255)
)


CREATE TABLE `food` (
  `food_id` INT PRIMARY KEY AUTO_INCREMENT,
  `food_name` VARCHAR(255),
  `image` VARCHAR(255),
  `price` FLOAT(6,2),
  `desc` VARCHAR(500),
  `type_id` INT,
  FOREIGN KEY (type_id) REFERENCES `food_type` (type_id)
);


CREATE TABLE `sub_food` (
	`sub_id` INT PRIMARY KEY AUTO_INCREMENT,
	`sub_name` VARCHAR(255),
	`sub_price` FLOAT(6,2),
	`food_id` INT,
	FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);


CREATE TABLE `order` (
	`user_id` INT,
	`food_id` INT,
	`amount` INT,
	`code` VARCHAR(255),
	`arr_sub_id` VARCHAR(255),
	FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
	FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
)


CREATE TABLE `rate_res` (
  `user_id` INT,
  `res_id` INT,
  `amount` INT,
  `date_rate` DATETIME,
  FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);


CREATE TABLE `like_res` (
  `user_id` INT,
  `res_id` INT,
  `date_like` DATETIME,
  FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);

-- Thêm dữ liệu vào table User
INSERT INTO
  `user` (`full_name`, `email`, `password`)
VALUES
  (
    'Nguyen Bao Anh',
    'ngbaoanh@gmail.com',
    'baoanh19#'
  ),
  (
    'Tran Anh Dung',
    'tranhdung@gmail.com',
    'adung99?'
  )


-- Thêm dữ liệu vào table Restaurant
INSERT INTO
  `restaurant` (`res_name`, `image`, `desc`)
VALUES (
    'Nhà hàng Phố 79',
    'https://statics.vincom.com.vn/xu-huong/nha-hang/Nha-hang-Pho-79.jpg',
    'Là một trong những điểm đến cho giới thượng lưu, nhà hàng Phố 79 với không gian ẩm thực sang trọng và chuyên nghiệp. Nhà hàng cung cấp từ những món ăn dân dã cho đến những món ăn từ những loại hải sản hiếm có như cá tầm, cá mặt quỷ. '
  )
  

INSERT INTO like_res (user_id, res_id, date_like) VALUES 
(1, 1, NOW()),
(2, 1, NOW()),
(1, 2, NOW());


-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT user_id, COUNT(*) AS like_count 
FROM like_res 
GROUP BY user_id 
ORDER BY like_count DESC 
LIMIT 5;


-- Tìm 2 nhà hàng có lượt like nhiều nhất.
SELECT res_id, COUNT(*) AS like_count 
FROM like_res 
GROUP BY res_id 
ORDER BY like_count DESC 
LIMIT 2;


-- Tìm người đã đặt hàng nhiều nhất.
SELECT user_id, COUNT(*) AS order_count 
FROM `order` 
GROUP BY user_id 
ORDER BY order_count DESC 
LIMIT 1;


-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng).
SELECT u.user_id, u.full_name 
FROM user u
LEFT JOIN `order` o ON u.user_id = o.user_id
LEFT JOIN like_res l ON u.user_id = l.user_id
LEFT JOIN rate_res r ON u.user_id = r.user_id
WHERE o.user_id IS NULL AND l.user_id IS NULL AND r.user_id IS NULL;





































