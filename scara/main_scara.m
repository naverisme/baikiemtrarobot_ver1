L(1) = Link([0,      30,  20,  0,   0]);
L(2) = Link([0,      0,   10,  0,   0]);
L(3) = Link([0,      5,   10,  pi,  0]);
L(4) = Link([-pi/2,  0,   0,   0,   1]);

L(4).qlim = [0 20];
scara = SerialLink(L, 'name', 'SCARA_4_DOF');

disp('--CHON QUY DAO--');
disp('1. duong thang');
disp('2. duong tron');
disp('3. hinh so 8');
choice = input('nhap lua chon: ');

n = 100;
switch choice
    case 1
        bat_dau = [25, 20, 25];
        ket_thuc =[25, -10, 25];
        toado = veduongthang(bat_dau, ket_thuc, n);
        title_str = "ve duong thang";
    case 2
        tam = [25, 20, 25];
        bankinh = 5;
        toado = vehinhtron(tam, bankinh, n);
        title_str = "ve duong tron";
    case 3
        tam = [25, 10, 25];
        kichthuoc = 8;
        toado = vehinhso8(tam, kichthuoc, n);
        title_str = "ve hinh so tam";
    otherwise
        error('chon lai');
end

%tinh dong hoc nghich cho cac diem
matrix_q = zeros(n, 4);
phi_0 = 0;
for i = 1:n
    px = toado(i, 1);
    py = toado(i, 2);
    pz = toado(i, 3);

    matrix_q(i, :) = Ik_scara(px, py, pz, phi_0);
end
figure('Name', title_str, 'Position', [100, 100, 900, 700]);

plot3(toado(:,1), toado(:,2), toado(:,3), 'r--', 'LineWidth', 1.5);
hold on; grid on; axis equal; view(3);

xlim([-60 60]);  
ylim([-60 60]);   
zlim([-10 60]);  


scara.plot(matrix_q(1, :), 'noshadow');

for i = 1:n
    scara.animate(matrix_q(i, :));
    plot3(toado(i,1), toado(i,2), toado(i,3), 'b*', 'MarkerSize', 6);
    drawnow;
    pause(0.1); 
end

disp('done!');