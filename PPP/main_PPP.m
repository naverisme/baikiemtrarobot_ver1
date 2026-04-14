

L(1) = Link([pi/2,  0, 0, pi/2, 1]);
L(2) = Link([-pi/2, 0, 0, pi/2, 1]);
L(3) = Link([0,     0, 0, 0,    1]);

L(1).qlim = [0 50]; 
L(2).qlim = [0 50]; 
L(3).qlim = [0 50]; 

PPP = SerialLink(L, 'name', 'PPP 3-DOF');

disp('--CHON QUY DAO -- ');
disp('1. ve duong thang');
disp('2. ve duong tron');
disp('3. ve hinh so 8');
choice = input('choice ');

N_points = 100;

switch choice
    case 1
        P_start = [10, -10, 15];
        P_end   = [40, -30, 35];
        quydao  = veduongthang(P_start, P_end, N_points);
        title_str = 've dung thang 3D';
        
    case 2
        Center = [25, -25, 25];
        Radius = 10;
        quydao = vehinhtron(Center, Radius, N_points);
        title_str = 've duong tron';
        
    case 3
        Center = [25, -20, 20];
        Scale = 8;
        quydao = vehinhso8(Center, Scale, N_points);
        title_str = 've hinh số 8';
        
    otherwise
        error('chon lai.');
end

matrix_q = zeros(N_points, 3);

for i = 1:N_points
    Px = quydao(i, 1);
    Py = quydao(i, 2);
    Pz = quydao(i, 3);
    
    matrix_q(i, :) = ik_ppp(Px, Py, Pz);
end
figure('Name', title_str, 'Position', [100, 100, 900, 700]);

plot3(quydao(:,1), quydao(:,2), quydao(:,3), 'r--', 'LineWidth', 1.5);
hold on; grid on; axis equal; view(135, 30);

xlim([-20 70]); 
ylim([-70 20]);  
zlim([-10 70]);
xlabel('Trục X (d2)'); ylabel('Trục Y (-d3)'); zlabel('Trục Z (d1)');

WS = [-20 70 -70 20 -10 70];

PPP.plot(matrix_q(1,:), 'noshadow', 'workspace', WS);
disp('Đang thực hiện quỹ đạo...');

for i = 1:N_points
    PPP.animate(matrix_q(i, :));
    
    plot3(quydao(i, 1), quydao(i, 2), quydao(i, 3), 'b*', 'MarkerSize', 6);
    
    drawnow;
    pause(0.04);
end

disp('Hoàn tất!');