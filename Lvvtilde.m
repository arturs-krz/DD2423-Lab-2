function pixels = Lvvtilde(inpic, shape)
if (nargin < 2)
shape = 'same';
end

% Central difference (all masks 5x5)
dxmask = [0 0 0; 0 0 0; -0.5 0 0.5; 0 0 0; 0 0 0];
dymask = dxmask';

dxymask = filter2(dxmask, dymask, 'same');

dxxmask = [0 0 0; 0 0 0; 1 -2 1; 0 0 0; 0 0 0];
dyymask = dxxmask';

Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);

Lxx = filter2(dxxmask, inpic, shape);
Lxy = filter2(dxymask, inpic, shape);
Lyy = filter2(dyymask, inpic, shape);

pixels = (Lx.^2 .* Lxx) + (2 * Lx .* Ly .* Lxy) + (Ly.^2 .* Lyyx);