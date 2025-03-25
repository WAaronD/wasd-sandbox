clearvars; close all; clc

%%
song = 'C:\Users\waaro\Documents\Personal\Jams and Preserves\One Man Show Project\Mixes\1 man show master 24b.wav';
fs0 = 192000; % Original sampling rate (Hz)
decim = 128; % Desired decimation factor
N = 256; % FFT window length
noverlap = N / 2; % window overlap

%% Load data
xn = audioread(song); % Read song to time series data
ch1_raw = xn(:, 1); % Only use first channel (either left or right, idk)
ch1 = decimate(ch1_raw, decim); % Decimate data
fs = 192000 / decim; % sampling rate after decimation

%% Timestamps
tstamps.v1 = 14.118;
tstamps.h1 = 63.529;
tstamps.int = 91.765;
tstamps.v2 = 105.882;
tstamps.h2 = 155.294;
tstamps.outro = 183.529;
tstamps.fin = 211.765;

%% Play song (if desired)
% song_audioplayer = audioplayer(xn, 192000);
% play(song_audioplayer) 

%% Plot
figure(1)
[s1, f, t] = spectrogram(ch1, hamming(N), noverlap, N, fs); % Calculate spectrogram for first channel
sdB1 = 20*log10(abs(s1) ./ max(abs(s1))); % Normalize amplitude and convert to dB

subplot(3, 1, 1)
imagesc(t(1:932), f, sdB1(:, 1:932))
set(gca, 'YDir', 'normal')
ylim([0 fs / 2]); clim([-40 5])
colormap(cmocean('-deep'));
ylabel('Frequency (Hz)')
set(gca, 'XTick', 0:5:80); set(gca, 'YTick', 0:100:800)
set(gca, 'Position', [.05 .7 .9 .25])

hold on
text(1, 675, 'intro', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
plot([tstamps.v1 tstamps.v1], [0 750], 'w', 'LineWidth', 2)
text(tstamps.v1 + 1, 675, 'verse 1', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
plot([tstamps.h1 tstamps.h1], [0 750], 'w', 'LineWidth', 2)
text(tstamps.h1 + 1, 675, 'hook 1', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
hold off

subplot(3, 1, 2)
imagesc(t(933:1864), f, sdB1(:, 933:1864))
set(gca, 'YDir', 'normal')
ylim([0 fs / 2]); clim([-40 5])
colormap(cmocean('-deep'));
ylabel('Frequency (Hz)')
set(gca, 'XTick', 80:5:160); set(gca, 'YTick', 0:100:800)
set(gca, 'Position', [.05 .4 .9 .25])

hold on
plot([tstamps.int tstamps.int], [0 750], 'w', 'LineWidth', 2)
text(tstamps.int + 1, 675, 'interlude', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
plot([tstamps.v2 tstamps.v2], [0 750], 'w', 'LineWidth', 2)
text(tstamps.v2 + 1, 675, 'verse 2', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
plot([tstamps.h2 tstamps.h2], [0 750], 'w', 'LineWidth', 2)
hold off

subplot(3, 1, 3)
imagesc(t(1865:2563), f, sdB1(:, 1865:2563))
set(gca, 'YDir', 'normal')
ylim([0 fs / 2]); clim([-40 5])
colormap(cmocean('-deep'));
ylabel('Frequency (Hz)'); xlabel('Time (s)')
set(gca, 'XTick', 160:5:220); set(gca, 'YTick', 0:100:800)
set(gca, 'Position', [.05 .1 .9*.75 .25])

hold on
text(160, 675, 'hook 2', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
plot([tstamps.outro tstamps.outro], [0 750], 'w', 'LineWidth', 2)
text(tstamps.outro + 1, 675, 'outro', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
plot([tstamps.fin tstamps.fin], [0 750], 'w', 'LineWidth', 2)
text(tstamps.fin + 1, 675, 'fin', 'Color', 'w', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
hold off

% Title
text(221, 550, '1 man show', 'Color', 'k', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Times')
text(221, 350, 'PACIFIC RIM EMPIRE', 'Color', 'k', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
text(221, 220, '(Aaron Deans)', 'Color', 'k', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')
text(221, 90, '2025', 'Color', 'k', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'Times')

% Export
set(gcf, 'Position', [0 50 1600 700])
saveas(gcf, 'C:\Users\waaro\Documents\Personal\Haus\sio_zine_sub.png')