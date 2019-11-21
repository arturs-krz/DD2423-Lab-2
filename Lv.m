function pixels = Lv(inpic, shape)
if (nargin < 2)
shape = 'same';
end

% Sobel (not flipped)
dxmask = [-1 0 1; -2 0 2; -1 0 1];
dymask = dxmask';

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);

pixels = Lx.^2 + Ly.^2;