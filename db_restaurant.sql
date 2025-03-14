USE db_restaurant;

CREATE TABLE
  `user` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `full_name` VARCHAR(255),
    `email` VARCHAR(255),
    `password` VARCHAR(255)
  );

CREATE TABLE
  `restaurant` (
    `res_id` INT PRIMARY KEY AUTO_INCREMENT,
    `res_name` VARCHAR(255),
    `image` VARCHAR(255),
    `desc` VARCHAR(255)
  )
CREATE TABLE
  `food_type` (
    `type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `type_name` VARCHAR(255)
  )
CREATE TABLE
  `food` (
    `food_id` INT PRIMARY KEY AUTO_INCREMENT,
    `food_name` VARCHAR(255),
    `image` VARCHAR(255),
    `price` DECIMAL(6, 2),
    `desc` VARCHAR(500),
    `type_id` INT,
    FOREIGN KEY (type_id) REFERENCES `food_type` (type_id)
  );

CREATE TABLE
  `sub_food` (
    `sub_id` INT PRIMARY KEY AUTO_INCREMENT,
    `sub_name` VARCHAR(255),
    `sub_price` FLOAT (6, 2),
    `food_id` INT,
    FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
  );

CREATE TABLE
  `order` (
    `user_id` INT,
    `food_id` INT,
    `amount` INT,
    `code` VARCHAR(255),
    `arr_sub_id` VARCHAR(255),
    FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
    FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
  )
CREATE TABLE
  `rate_res` (
    `user_id` INT,
    `res_id` INT,
    `amount` INT,
    `date_rate` DATETIME,
    FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
    FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
  );

CREATE TABLE
  `like_res` (
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
    'Ten Nguoi Dung Moi 1',
    'email1@example.com',
    'password1'
  ),
  (
    'Ten Nguoi Dung Moi 2',
    'email2@example.com',
    'password2'
  );

SELECT
  *
FROM
  `user`;

-- Thêm dữ liệu vào table Restaurant
INSERT INTO
  `restaurant` (`res_name`, `image`, `desc`)
VALUES
  (
    'Nhà hàng Phố 79',
    'https://statics.vincom.com.vn/xu-huong/nha-hang/Nha-hang-Pho-79.jpg',
    'Là một trong những điểm đến cho giới thượng lưu, nhà hàng Phố 79 với không gian ẩm thực sang trọng và chuyên nghiệp. Nhà hàng cung cấp từ những món ăn dân dã cho đến những món ăn từ những loại hải sản hiếm có như cá tầm, cá mặt quỷ. '
  )
SELECT
  *
FROM
  restaurant;

-- Thêm dữ liệu vào table food_type
INSERT INTO
  `food_type` (`type_name`)
VALUES
  ('Pizza'),
  ('Burger'),
  ('Sushi'),
  ('Noodles'),
  ('Salad'),
  ('Dessert'),
  ('Beverage');

SELECT
  *
FROM
  `food_type`;

-- Thêm dữ liệu vào table food
INSERT INTO
  `food` (`food_name`, `image`, `price`, `desc`, `type_id`)
VALUES
  (
    'Pizza Hải Sản',
    'pizza.jpg',
    50000.00,
    'Pizza hải sản đặc biệt',
    1
  ),
  (
    'Burger Bò Nướng',
    'burger.jpg',
    150000.00,
    'Burger bò thơm ngon',
    2
  ),
  (
    'Sushi Cá Hồi',
    'sushi.jpg',
    200000.00,
    'Sushi tươi sống Nhật Bản',
    3
  ),
  (
    'Mì Ramen',
    'ramen.jpg',
    120000.00,
    'Mì ramen Nhật Bản',
    4
  ),
  (
    'Salad Trộn',
    'salad.jpg',
    90000.00,
    'Salad rau củ trộn',
    5
  ),
  (
    'Pepsi',
    'pepsi.jpg',
    10000.00,
    'Nước ngọt Pepsi',
    7
  )
SELECT
  *
FROM
  `food`;

ALTER TABLE food MODIFY COLUMN price DECIMAL(10, 2);

-- Thêm dữ liệu vào bảng sub_food
INSERT INTO
  sub_food (sub_name, sub_price, food_id)
VALUES
  ('Phô mai thêm', 50.00, 1),
  ('Xúc xích thêm', 30.00, 1),
  ('Khoai tây chiên', 40.00, 2),
  ('Sốt teriyaki', 20.00, 3),
  ('Trứng luộc', 15.00, 4),
  ('Dưa leo', 10.00, 5);

SELECT
  *
FROM
  `sub_food`;

ALTER TABLE `sub_food` MODIFY COLUMN `sub_price` DECIMAL(10, 2);

-- Thêm dữ liệu vào table order
INSERT INTO
  `order` (
    `user_id`,
    `food_id`,
    `amount`,
    `code`,
    `arr_sub_id`
  )
VALUES
  (1, 1, 5, 'ORD001', '1,2'),
  (1, 2, 1, 'ORD002', '3'),
  (2, 1, 3, 'ORD003', '1,2,3'),
  (3, 3, 1, 'ORD004', '2'),
  (4, 2, 2, 'ORD005', '');

SELECT
  *
FROM
  `order`;

-- Thêm dữ liệu vào bảng like_res
INSERT INTO
  `like_res` (`user_id`, `res_id`, `date_like`)
VALUES
  (4, 3, NOW ()),
  (2, 3, NOW ());

SELECT
  *
FROM
  `like_res`;

-- Thêm dữ liệu vào bảng rate_res
INSERT INTO
  `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`)
VALUES
  (1, 1, 5, NOW ()),
  (2, 2, 4, NOW ()),
  (3, 3, 3, NOW ()),
  (1, 3, 4, NOW ()),
  (2, 3, 5, NOW ());

SELECT
  *
FROM
  `rate_res`;

-- Tìm 5 người đã like nhà hàng nhiều nhất.
SELECT
  `user_id`,
  COUNT(*) AS `like_count`
FROM
  `like_res`
GROUP BY
  `user_id`
ORDER BY
  `like_count` DESC
LIMIT
  5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất.
SELECT
  res_id,
  COUNT(*) AS like_count
FROM
  like_res
GROUP BY
  res_id
ORDER BY
  like_count DESC
LIMIT
  2;

-- Tìm người đã đặt hàng nhiều nhất.
SELECT
  `user_id`,
  COUNT(*) AS `order_count`
FROM
  `order`
GROUP BY
  `user_id`
ORDER BY
  `order_count` DESC
LIMIT
  1;

-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng).
SELECT
  `u`.`user_id`,
  `u`.`full_name`
FROM
  `user` `u`
  LEFT JOIN `order` `o` ON `u`.`user_id` = `o`.`user_id`
  LEFT JOIN `like_res` `l` ON `u`.`user_id` = `l`.`user_id`
  LEFT JOIN `rate_res` `r` ON `u`.`user_id` = `r`.`user_id`
WHERE
  `o`.`user_id` IS NULL
  AND `l`.`user_id` IS NULL
  AND `r`.`user_id` IS NULL;

-- ========== END ==========