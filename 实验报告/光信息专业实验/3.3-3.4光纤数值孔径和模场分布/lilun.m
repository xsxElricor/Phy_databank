% 定义网格参数
x = linspace(-5, 5, 200);  % 增加点数提高分辨率
y = linspace(-5, 5, 200);
[X, Y] = meshgrid(x, y);

% 定义模式的权重
mode_weights = struct('LP01', 0, 'LP11', 0, 'LP21', 1, 'LP02', 0.4);

% 计算叠加模式
combined_mode = combine_modes(X, Y, mode_weights);

% 绘图
figure;
imagesc(x, y, combined_mode);
axis image;                     % 保持比例
set(gca, 'YDir', 'normal');     % y 轴向上
colorbar;
colormap jet;
title('Mode Field Distribution');
xlabel('X');
ylabel('Y');

%% 
% 多模式叠加函数
function combined_mode = combine_modes(x, y, mode_weights)
    combined_mode = zeros(size(x));
    mode_list = fieldnames(mode_weights);
    for i = 1:numel(mode_list)
        mode_type = mode_list{i};
        weight = mode_weights.(mode_type);
        if weight ~= 0
            mode = mode_field_distribution(x, y, mode_type);
            combined_mode = combined_mode + weight * mode;
        end
    end
end

% 单一模式的场分布函数（已对称居中）
function mode = mode_field_distribution(x, y, mode_type)
    switch mode_type
        case 'LP01'
            % 中心高斯（基模）
            mode = exp(-(x.^2 + y.^2) / 2);
        case 'LP11'
            % 双瓣模式：x方向奇对称
            mode = x .* exp(-(x.^2 + y.^2));
        case 'LP21'
            % 三瓣模式：x方向二阶对称
            mode = exp(- ((x+2) .^ 2 + y .^ 2) / 2) + exp(- ((x-2) .^ 2 + y .^ 2) / 2) + exp(- (x .^ 2 + (y+2) .^ 2) / 2) + exp(- (x .^ 2 + (y-2) .^ 2) / 2);
        case 'LP02'
            % 中心凹陷的圆对称模式（类似环形）
            mode = 2.5 * abs(1.4 * exp(- (x .^ 2 + y .^ 2) / 0.8) - exp(- (x .^ 2 + y .^ 2) / 2));
        otherwise
            error('Unsupported mode type: %s', mode_type);
    end
    % 取绝对值确保结果为强度（可选）
    mode = abs(mode);
end
