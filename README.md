# Sleep State Analysis through HRV in Full-Term Neonates

## Introduction
Monitoring the Autonomic Nervous System (ANS) within the first year of life is essential for neonate health. Infants spend most of their first year sleeping, presenting two distinct sleep states: active sleep (AS) and quiet sleep (QS). AS is associated with rapid eye movements (REM) and increased cardiorespiratory rates variability, while QS lacks these characteristics. The ANS, divided into sympathetic and parasympathetic systems, is crucial for maintaining physiological functions. This study aims to highlight the ANS role during both AS and QS using HRV analysis.

## Materials and Methods

### Dataset
The dataset consists of five ECG signals recorded on full-term neonates, sampled at 500Hz and segmented into three-minute sections labeled as AS or QS. The final dataset comprises eleven ECG frames (six QS, five AS).

### Signal Processing
Initial analysis showed the signals were already filtered at 0Hz and 60Hz. A third-order Butterworth low-pass filter at 50Hz was applied to preserve R-peaks and improve peak detection. Both MATLAB's `findpeaks` and Pan-Tompkin algorithms were tested, with `findpeaks` chosen for most frames. Ectopic beats were manually corrected.

### Time Domain Analysis
Time domain analysis included observing tachogram, histogram, and scatterplot. Key statistical measures for HRV studies on short-term signals were computed, such as mean RR intervals (avgHRV), RR range, RMSSD, SDNN, ApEn, and SampEn.

### Frequency Domain Analysis
Power Spectrum Density (PSD) was computed using non-parametric (Welch method) and parametric (Yule-Walker method) approaches. Signals were processed, resampled at 6Hz, and subjected to spline interpolation. The stationarity was checked using the Augmented Dickey-Fuller test. PSD was analyzed for Low Frequencies (LF) and High Frequencies (HF), as well as the LF/HF ratio.

## Results

### Time Domain Results
AS showed wider RR range and higher variability (RMSSD, SDNN) compared to QS, although avgHRV did not differ significantly. ApEn and SampEn were higher during QS, indicating less repetitive patterns and higher complexity.

| Variable    | QS (Mean ± STD) | AS (Mean ± STD) | p-Value |
|-------------|------------------|------------------|---------|
| avgHRV [ms] | 513.55 ± 38.72   | 512.31 ± 50.96   | ≥ 0.1   |
| RR range [ms]| 263.00 ± 142.13  | 296.20 ± 193.01  | ≥ 0.1   |
| RMSSD [ms]  | 28.29 ± 24.60    | 31.60 ± 26.12    | ≥ 0.1   |
| SDNN [ms]   | 38.82 ± 21.65    | 46.98 ± 22.24    | ≥ 0.1   |
| ApEn        | 1.12 ± 0.04      | 1.00 ± 0.10      | < 0.05  |
| SampEn      | 1.42 ± 0.25      | 1.11 ± 0.26      | < 0.1   |

### Frequency Domain Results
AS had greater spectral density in both LF and HF ranges, with a higher LF/HF ratio, indicating greater ANS activity, particularly in the sympathetic system. However, no frequency domain parameters showed statistical significance in distinguishing AS from QS.

| Variable      | QS (Median [IQR]) | AS (Median [IQR]) | p-Value |
|---------------|--------------------|-------------------|---------|
| LF (W) [ms²/Hz] | 71641 [74742]      | 107606 [222154]    | ≥ 0.1   |
| HF (W) [ms²/Hz] | 9345 [20572]       | 9042 [97902]       | ≥ 0.1   |
| LF (YW) [ms²/Hz]| 62284 [79264]      | 122667 [182075]    | ≥ 0.1   |
| HF (YW) [ms²/Hz]| 14066 [20532]      | 8271 [105444]      | ≥ 0.1   |
| LF/HF (W)       | 7.65 [7.35]        | 5.75 [21.67]       | ≥ 0.1   |
| LF/HF (YW)      | 6.18 [4.41]        | 3.81 [12.42]       | ≥ 0.1   |

</br>
</br>





<details>
    <summary>Instructions</summary>

## Setup 

- Open a command prompt and execute:
    ```console
    git clone https://github.com/RaffaeleBerzoini/HRV_in_neonates.git
    ```

## Execution

- Once the project has been downloaded, head into the project working directory and execute on the Matlab command prompt: 
    ```shell
    >> main
    ```
    
- Some Dialogue Boxes will guide you during the execution. 
- After the execution, you will find two _.xls_ files (one for time domain and one for frequency domain) in the working directory with all the calculated parameters for each subject selected. 
- If statistical analysis is requested, two additional _.xls_ files are generated. These files will contain all the statistical indexes and tests computed on the parameters of the first two _.xls_ files.

## Report

- A 2-pages report is provided to explain the choices made during the implementation and the observations about the results obtained.

</details>

## Authors
- Raffaele Berzoini
- Aurora Anna Francesca Colombo
- Davide Console
