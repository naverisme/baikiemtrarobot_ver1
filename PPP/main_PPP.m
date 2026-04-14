%% CHƯƠNG TRÌNH ĐIỀU KHIỂN ROBOT CARTESIAN (PPP) - VẼ 3 QUỸ ĐẠO
clear; clc; close all;

%% 1. KHỞI TẠO MÔ HÌNH ROBOT CARTESIAN
% Tham số sigma = 1 khai báo đây là Khớp Tịnh Tiến (Prismatic)
L(1) = Link([pi/2,  0, 0, pi/2, 1]);
L(2) = Link([-pi/2, 0, 0, pi/2, 1]);
L(3) = Link([0,     0, 0, 0,    1]);

% Cài đặt giới hạn trượt (Hành trình động cơ từ 0 đến 50cm)
L(1).qlim = [0 50]; % Trục Z
L(2).qlim = [0 50]; % Trục X
L(3).qlim = [0 50]; % Trục Y

cartesian = SerialLink(L, 'name', 'Cartesian 3-DOF');

%% 2. MENU CHỌN QUỸ ĐẠO
disp('--- CHỌN QUỸ ĐẠO MÔ PHỎNG ---');
disp('1. Đường thẳng 3D');
disp('2. Đường tròn trên mặt phẳng');
disp('3. Đường tự chọn (Hình số 8)');
choice = input('Nhập lựa chọn của bạn (1/2/3): ');

N_points = 100;

switch choice
    case 1
        % Đường thẳng xéo trong không gian
        P_start = [10, -10, 15];
        P_end   = [40, -30, 35];
        P_traj  = veduongthang(P_start, P_end, N_points);
        title_str = 'Mô phỏng Cartesian: Đường Thẳng 3D';
        
    case 2
        % Đường tròn lơ lửng ở cao độ Z=25
        % Tâm dời về Y=-25 để d3 luôn trượt dương
        Center = [25, -25, 25];
        Radius = 10;
        P_traj = vehinhtron(Center, Radius, N_points);
        title_str = 'Mô phỏng Cartesian: Đường Tròn 2D';
        
    case 3
        % Hình số 8 (Vô cực) ở cao độ Z=20
        Center = [25, -20, 20];
        Scale = 8;
        P_traj = vehinhso8(Center, Scale, N_points);
        title_str = 'Mô phỏng Cartesian: Hình Số 8';
        
    otherwise
        error('Lựa chọn không hợp lệ! Vui lòng chạy lại chương trình.');
end

%% 3. TÍNH TOÁN ĐỘNG HỌC NGHỊCH
Q_traj = zeros(N_points, 3);

for i = 1:N_points
    Px = P_traj(i, 1);
    Py = P_traj(i, 2);
    Pz = P_traj(i, 3);
    
    % Gọi hàm IK (d1=Z, d2=X, d3=-Y)
    Q_traj(i, :) = ikine_Cartesian(Px, Py, Pz);
end

%% 4. MÔ PHỎNG 3D VÀ ĐÁNH DẤU VẾT (*)
figure('Name', title_str, 'Position', [100, 100, 900, 700]);

% Vẽ quỹ đạo lý thuyết màu đỏ
plot3(P_traj(:,1), P_traj(:,2), P_traj(:,3), 'r--', 'LineWidth', 1.5);
hold on; grid on; axis equal; view(135, 30);

% Ép khung nhìn để thấy được toàn cảnh hệ trục
xlim([0 50]); 
ylim([-50 0]);  % Trục Y cố tình để âm
zlim([0 60]);
xlabel('Trục X (d2)'); ylabel('Trục Y (-d3)'); zlabel('Trục Z (d1)');

% Khởi tạo robot
% Sử dụng workspace rộng để không bị cắt xén đồ họa
WS = [-10 60 -60 10 0 60];
cartesian.plot(Q_traj(1,:), 'noshadow', 'workspace', WS);

disp('Đang thực hiện quỹ đạo...');

for i = 1:N_points
    cartesian.animate(Q_traj(i, :));
    
    % Vẽ sao xanh tại vị trí tool
    plot3(P_traj(i, 1), P_traj(i, 2), P_traj(i, 3), 'b*', 'MarkerSize', 6);
    
    drawnow;
    pause(0.04);
end

disp('Hoàn tất!');