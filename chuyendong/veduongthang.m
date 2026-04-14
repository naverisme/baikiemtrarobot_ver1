function P = veduongthang(batdau, ketthuc, n)
    X = linspace(batdau(1), ketthuc(1), n)';
    Y = linspace(batdau(2), ketthuc(2), n)';
    Z = linspace(batdau(3), ketthuc(3), n)';
    
    % Gộp lại thành ma trận n hàng, 3 cột
    P = [X, Y, Z];
end