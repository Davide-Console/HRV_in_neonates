%% Clear workspace
clear; clc; close all;
%% load subject data
subject_number = 5; %Insert a number from 1 to 5
min_height = [4000, 3900, 6200, 1000, 740];

[ecg, active_quiet_state] = getEcg_SleepActivity(subject_number);
f_s = 500;
T = (length(ecg)/f_s)-(1/f_s);
t = 0:1/f_s:T;
%% spectrum
spectrum = abs(fft(ecg - mean(ecg) ,4096));

f = linspace(0,f_s,length(spectrum));
w = f/f_s; %omega

figure(1);
subplot(1,2,1); plot(t,ecg); title('ECG', 'Interpreter', 'none'); xlabel('Time [s]'); ylabel('Amplitude [mV]');
subplot(1,2,2); plot(f,spectrum); title('Spectrum', 'Interpreter', 'none'); xlabel('Frequency [Hz]'); ylabel('|X(f)|');

%% filters application

filter_order = 3;
fcut = 50;       % cut-off frequency [Hz]
wc = fcut/(f_s/2); % NORMALIZED cut-off frequency
[b,a] = butter(filter_order,wc,'low');
ecg=filtfilt(b, a, ecg);
figure; freqz(b,a,1024,f_s);

spectrum = abs(fft(ecg - mean(ecg) ,4096));

f = linspace(0,f_s,length(spectrum));
figure(5); plot(f, spectrum)

%% R-peaks detection

[~,r_peaks_pt,~, ~, r_peaks_fp] = r_peaks_detection(ecg, f_s, 1, min_height(subject_number));

if subject_number == 4
    ecg_flipped = flip(ecg);
    [qrs_amp_raw,r_peaks_flip,delay, ~, ~] = r_peaks_detection(ecg_flipped,f_s,1,0);
    r_peaks_pt = [r_peaks_pt(1:find(r_peaks_pt(:)==222200)-1), abs(r_peaks_flip(1:find(r_peaks_flip(:)==94141))-length(ecg))]; 
end

figure(34);
sb(1) = subplot(2,1,1); plot(t, ecg); hold on; plot((r_peaks_pt)/f_s, ecg(r_peaks_pt),'ok'); title('Pan-Tompkins Mod', 'Interpreter', 'none'); ylabel('Amplitude [mV]');
sb(2) = subplot(2,1,2); plot(t, ecg); hold on; plot((r_peaks_fp)/f_s, ecg(r_peaks_fp),'ok'); title('Find Peaks', 'Interpreter', 'none'); ylabel('Amplitude [mV]');
xlabel('time [s]'); 
linkaxes(sb,'x'); %to use the same axes for the subplots

%% Tachogram
RRintervals = time_intervals(r_peaks_fp, f_s);

[x, y] = tachogram(RRintervals);
figure(35);
plot(x,y); title('ECG Tachogram'),xlabel('Beats'),ylabel('Time [s]');

%% Histogram

figure(36);
histogram(y,ceil((max(y)-min(y))/(1/f_s))); title('ECG Histogram of RR peaks'),xlabel('Duration [s]'),ylabel('Occurrence');

%% Scattergram

figure(37);
plot(y(1:end-1),y(2:end),'.'); title('ECG Scattergram'),xlabel('(R-R)_{i}'),ylabel('(R-R)_{i+1}')

%% Time Domain Analysis
[avgHR,avgHRV,diff, RMSSD, SDNN] = time_domain_analysis(f_s, T, r_peaks_pt, RRintervals);


