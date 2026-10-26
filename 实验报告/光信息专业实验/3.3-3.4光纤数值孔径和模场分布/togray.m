
clc,clear,close all;

img_path = "D:\Documentary\sysu\2024-2\3-光信息实验\3.3-3.4\LP21裁剪.jpg";
% 读取图像
img = imread(img_path);

% 原始图像
figure;
imshow(img);
title('原始图像');

% 灰度化图像
gray_img = rgb2gray(img);

figure;
imshow(gray_img);
title('灰度图像')

% 计算图像中灰度值最大的位置
[max_val, max_index] = max(gray_img(:));
[max_row, max_col] = ind2sub(size(gray_img), max_index);

% 计算图像中心
[rows, cols] = size(gray_img);
center_row = floor(rows / 2); % 图像的垂直中心
center_col = floor(cols / 2); % 图像的水平中心

% 水平方向灰度变化
horizontal_gray = gray_img(center_row, :);

 % 归一化水平方向灰度变化
max_gray = double(max(horizontal_gray));
normalized_horizontal_gray = double(horizontal_gray) / max_gray;

figure;
% 绘制灰度变化图
plot(1:length(normalized_horizontal_gray), normalized_horizontal_gray);
hold on;
title('LP21实验光强分布图');
xlabel('水平位置');
ylabel('归一化光强');

