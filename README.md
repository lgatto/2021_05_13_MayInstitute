# Computation and statistics for mass spectrometry and proteomics

- May 3 – May 14, 2021
- Northeastern University, Boston MA
- [https://computationalproteomics.khoury.northeastern.edu/](https://computationalproteomics.khoury.northeastern.edu/)

## Reproducible Mass Spectrometry-based Research

- May 13, 2021
- 11:00am - 12:30pm (17:00 - 18:30 CEST)

Reproducible research has been on the radar of many of us for several
years now. While most agree that reproducibility is a noble feature
that we should all strive for, it might at times appear that working
reproducibly is an additional difficulty in computational research and
data analysis, that already come across as difficult tasks for
non-experts.

I will start by motivating my desire to work reproducibly: increasing
trust in my work, for myself and my readers. There exist many
solutions to support reproducible research, some relatively simple to
implement, and others that rely on more complex solutions. While
extremely elaborate and powerful, the latter often suffer from a
substantial increase in complexity and transparency. At the end of the
day, whether the needs for reproducibility are simple or complex,
whether they require the utilisation of simple or more elaborate
solutions, I would argue that it all boils down to the researcher's
self discipline, and their desire to maximise transparency.

I will demonstrate some of the tools I develop and, more importantly,
that I use on a daily basis, to promote reproducibility and
transparency in my work. These tools are developed openly and
collaboratively in the frame of the [R for Mass
Spectrometry](https://www.rformassspectrometry.org/) initiative.


- Get the **[slides](slides.html)**
- Read the **[talk notes](https://lgatto.github.io/keynote-may-institute/)**
- Get the **[code](https://github.com/lgatto/2021_05_13_MayInstitute/blob/main/code.R)**

#### Setup

If you would like to be able to reproduce the analysis I will
demonstrate, please use a recent version of R (>= 4) and install the
following packages.

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("msdata")
BiocManager::install("mzR")
BiocManager::install("lgatto/ProtGenerics")
BiocManager::install("lgatto/rpx")
BiocManager::install("RforMassSpectrometry/MsExperiment")
BiocManager::install("RforMassSpectrometry/MsCoreUtils")
BiocManager::install("RforMassSpectrometry/PSM")
BiocManager::install("RforMassSpectrometry/Spectra")
```

If you hit any installation issues, don't hesitate to open a GitHub
[issue](https://github.com/rformassspectrometry/docs/issues/new) or
contact me by email.

#### Reading material

To familiarise yourself with the *R for Mass Spectrometry*
infrastructure:

- [R for Mass Spectrometry
  tutorials](https://rformassspectrometry.github.io/docs/), Laurent
  Gatto, Sebastian Gibb and Johannes Rainer (2021).

To learn about the raw data infrastructure:

- Gatto Laurent, Gibb Sebsatien and Rainer Johannes *MSnbase,
  efficient and elegant R-based processing and visualisation of raw
  mass spectrometry data* J. Proteome Res. 2021
  https://doi.org/10.1021/acs.jproteome.0c00313

(Even though this paper describes the
[MSnbase](http://lgatto.github.io/MSnbase/) raw data backends, it also
applies to the
[Spectra](https://rformassspectrometry.github.io/Spectra/articles/Spectra.html)
package.)


#### License

The material in this repositry is made available under a [Creative
Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).
