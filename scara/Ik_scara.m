function q = Ik_scara(px, py, pz, phi)

%ta có kích thước được giả định như sau:
d1 = 30; a1 = 20;
d2 = 0; a2 = 10;
d3 = 5; a3 = 10;

d4 = d1 - d2 + d3 - pz;

xw = px - a3*cos(phi);
yw = py - a3*sin(phi);

c2 = (xw^2 + yw^2 - a1^2 - a2^2)/ (2 * a1*a2);
if c2 <-1 || c2 >1
    error('Tọa độ [%.2f, %.2f, %.2f] ngoài tầm ', px, py, pz);
end

s2 = sqrt(1 - c2^2);
q2 = atan2(s2,c2);

k1 = a1 + a2*c2;
q1 = atan2(yw, xw) - atan2(a2*s2, k1);

q3 = phi - q1 - q2;

q = [q1, q2, q3, d4];
end
