function filtered = gaussfft(pic, t)
sz = size(pic);
%kernel = zeros(sz);
% grid = meshgrid(1:sz(1), 1:sz(2));
x = (-sz(1) / 2):(sz(1) / 2 - 1);
y = (-sz(2) / 2):(sz(2) / 2 - 1);

% display(grid);
gaussianX = (1 / (sqrt(2*pi*t))) .* exp(-(x.^2)/(2*t));
gaussianY = (1 / (sqrt(2*pi*t))) .* exp(-(y.^2)/(2*t));
gaussian = gaussianX' * gaussianY;

Fhat = fft2(pic);
Ghat = fft2(gaussian);
FGhat = Fhat .* Ghat;

filtered = abs(ifft2(FGhat));
filtered = circshift(filtered, -sz / 2);
end