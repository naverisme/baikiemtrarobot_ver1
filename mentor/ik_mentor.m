function [q_Up, q_Down] = ik_mentor(Px, Py, Pz, phi_pitch_deg, theta5_roll_deg)

    phi_user = deg2rad(phi_pitch_deg);
    phi_math = pi/2 - phi_user; 
    th5 = deg2rad(theta5_roll_deg);

   d1 = 30; a2 = 20; a3 = 15; d5 = 10;

    th1 = atan2(Py, Px);

    R = sqrt(Px^2 + Py^2);
    Rw = R - d5 * sin(phi_math);
    Zw_prime = Pz - d1 - d5 * cos(phi_math);

    D2 = Rw^2 + Zw_prime^2;
    c3 = (D2 - a2^2 - a3^2) / (2 * a2 * a3);

    if c3 < -1 || c3 > 1
        error('Toa do nam ngoai tam ');
    end

    s3_up = sqrt(1 - c3^2);
    th3_std_up = atan2(s3_up, c3);
    th3_std_down = atan2(-s3_up, c3);

    alpha = atan2(Zw_prime, Rw);
    
    beta_up = atan2(a3 * s3_up, a2 + a3 * c3);
    th2_std_up = alpha - beta_up;
    
    beta_down = atan2(a3 * (-s3_up), a2 + a3 * c3);
    th2_std_down = alpha - beta_down;

    th2_up = -th2_std_up;
    th3_up = -th3_std_up;
    th2_down = -th2_std_down;
    th3_down = -th3_std_down;

    th4_up = phi_math - th2_up - th3_up;
    th4_down = phi_math - th2_down - th3_down;

    q_Up = [th1, th2_up, th3_up, th4_up, th5];
    q_Down = [th1, th2_down, th3_down, th4_down, th5];
end