
L(1) = Link([0,  30, 0,  -pi/2, 0]);
L(2) = Link([0,  0,  20, 0,     0]);
L(3) = Link([0,  0,  15, 0,     0]);
L(4) = Link([0,  0,  0,  pi/2,  0]);
L(5) = Link([0,  10, 0,  0,     0]);
mentor = SerialLink(L, 'name', 'Mentor_5_DOF');

disp('-- CHON QUY DAO  ---');
disp('1. Duong thang 3D');
disp('2. Duong tron mat phang');
disp('3. Hinh so 8');
choice = input(' chon: ');
n = 100;

switch choice
    case 1
        toado = veduongthang([40, 10, 20], [25, -10, 30], n);
        title_str = "Quy dao Duong Thang";
    case 2
        toado = vehinhtron([25, 0, 25], 8, n);
        title_str = "Quy dao Duong Tron";
    case 3
        toado = vehinhso8([30, 0, 25], 5, n);
        title_str = "Quy dao Hinh so 8";
    otherwise
        error('chon lai');
end

matrix_q = zeros(n, 5);
pitch = 0; 
roll = 0;

for i = 1:n
    [q1, q2] = ik_mentor(toado(i,1), toado(i,2), toado(i,3), pitch, roll);
    matrix_q(i, :) = q1; 
end

figure('Name', title_str, 'Position', [100, 100, 800, 600]);
plot3(toado(:,1), toado(:,2), toado(:,3), 'r--', 'LineWidth', 1.5);
hold on; grid on; axis equal; view(135, 30);

xlim([-60 60]); ylim([-60 60]); zlim([-10 70]);

mentor.plot(matrix_q(1,:), 'noshadow');

for i = 1:n
    mentor.animate(matrix_q(i, :));
    plot3(toado(i,1), toado(i,2), toado(i,3), 'b*', 'MarkerSize', 6);
    drawnow;
    pause(0.03);
end
disp(' hoan tat');