% cgrad.m
function colorgrad = cgrad(col1, col2, interm)
% Given two or more colors, create a gradient between them.

% WASD 2024/04/08 - Created cgrad.m

% Debugging defaults
% col1 = '#FF0000';
% col2 = '#00FF88';
% interm = 10;

% Get r, g, b in decimal
r1 = hex2dec(col1(2:3));
g1 = hex2dec(col1(4:5));
b1 = hex2dec(col1(6:7));
r2 = hex2dec(col2(2:3));
g2 = hex2dec(col2(4:5));
b2 = hex2dec(col2(6:7));

% Create r, g, b gradients
rgrad = dec2hex(round(linspace(r1, r2, interm)));
ggrad = dec2hex(round(linspace(g1, g2, interm)));
bgrad = dec2hex(round(linspace(b1, b2, interm)));

% Account for case where rgrad, ggrad, and/or bgrad is a one-digit column
if size(rgrad, 2) == 1 || size(ggrad, 2) == 1 || size(bgrad, 2) == 1
    rgrad = [num2str(zeros(interm, 1)) rgrad]; % Add column of zeros
    rgrad = rgrad(:, (end-1):end); % Reduce to two columns
    ggrad = [num2str(zeros(interm, 1)) ggrad]; % Add column of zeros
    ggrad = ggrad(:, (end-1):end); % Reduce to two columns
    bgrad = [num2str(zeros(interm, 1)) bgrad]; % Add column of zeros
    bgrad = bgrad(:, (end-1):end); % Reduce to two columns
end

% Combine
hashvec = repmat('#', interm, 1);
colorgrad = string([hashvec rgrad ggrad bgrad]);

% Plot for user
figure('Name','gradient','NumberTitle','off');
for col = 1:length(colorgrad)
    rectangle('Position', [0, col-1, 1, 1],'FaceColor', ...
        colorgrad(col), 'EdgeColor', 'none')
    hold on
end
xlim([0 1])
ylim([0 length(colorgrad)])
xticks([])
yticks([])