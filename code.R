## All details and links at
## https://lgatto.github.io/2021_05_13_MayInstitute/

## I use emacs and ess, but RStudio is great and everything I showed
## will also work.


## -----------------------------
## Package installation
## -----------------------------

## BiocManager::install("msdata")
## BiocManager::install("mzR")
## BiocManager::install("lgatto/ProtGenerics")
## BiocManager::install("lgatto/rpx")
## BiocManager::install("RforMassSpectrometry/MsExperiment")
## BiocManager::install("RforMassSpectrometry/MsCoreUtils")
## BiocManager::install("RforMassSpectrometry/PSM")
## BiocManager::install("RforMassSpectrometry/Spectra")
## BiocManager::install("RforMassSpectrometry/SpectraVis")

## -----------------------------
## Environment
## -----------------------------
library("rpx")
library("MsExperiment")
library("Spectra")
library("SpectraVis")
library("ggplot2")
library("tidyr")
library("magrittr")
library("PSM")

## -----------------------------
## Getting public data
## -----------------------------

## https://www.ebi.ac.uk/pride/archive/projects/PXD022816
##
## Morgenstern D, Barzilay R, Levin Y. RawBeans: A Simple,
## Vendor-Independent, Raw-Data Quality-Control Tool. J Proteome
## Res. 2021, PubMed: 33657803

px <- PXDataset("PXD022816")
px

(fls <- pxfiles(px))
(mzmls <- pxget(px, grep("mzML", pxfls)[1:3]))
(mzids <- pxget(px, grep("mzID", pxfls)[1:3]))

## -----------------------------
## An MS experiment
## -----------------------------

mse <- MsExperiment()
mse

experimentFiles(mse) <- MsExperimentFiles(mzmls = mzmls, mzids = mzids)

mse

metadata(mse)$pxd <- "PXD022816"
metadata(mse)$pmid <- "33657803"

## -----------------------------
## Raw data
## -----------------------------

sp <- Spectra(experimentFiles(mse)$mzmls)

spectraVariables(sp)
spectraData(sp)

length(sp)
sp[1:2]

peaksData(sp[1:2])[[1]]

plotSpectra(sp[1])
plotSpectra(sp[23822])

plotlySpectra(sp[1])

table(precursorCharge(sp))

table(sp$dataOrigin)

table(sp$msLevel, sp$centroided)


filterMsLevel(sp, 1) %>%
    spectraData() %>%
    as_tibble() %>%
    ggplot(aes(x = rtime,
               y = totIonCurrent,
               colour = basename(dataOrigin))) +
    geom_line()


## https://gist.github.com/lgatto/7de0bc9fd712b01604ef67c714580e78

d1 <- sp %>%
    filterDataOrigin(experimentFiles(mse)$mzmls[1]) %>%
    computeMzDeltas()

plotMzDelta(d1)

spectra(mse) <- sp
mse

## -----------------------------
## Identicication data
## -----------------------------

id <- PSM(experimentFiles(mse)$mzids)
id
names(id)


tidyr::as_tibble(id) %>%
    ggplot(aes(x = MetaMorpheus.score,
               colour = isDecoy)) +
    geom_density() +
    facet_wrap(~ spectrumFile)

tidyr::as_tibble(id) %>%
    ggplot(aes(x = PSM.level.q.value,
               colour = isDecoy)) +
    geom_density() +
    facet_wrap(~ spectrumFile)


id <- filterPSMs(id)
id

## -----------------------------
## Joining raw and id data
## -----------------------------

spectraVariables(sp)

names(id)

sp$pkey <- paste0(sub("^.+QEP", "QEP", basename(sp$dataOrigin)),
                  sub("^.+scan=", "::", sp$spectrumId))

tail(sp$pkey)

id$pkey <- paste0(sub("^.+QEP", "QEP", id$spectrumFile),
                  sub("^.+scan=", "::", id$spectrumID))

head(id$pkey)

head(id$pkey)

## For simplicity, let keep single hits per spectrum id.
id <- id[!duplicated(id$pkey), ]

sp <- joinSpectraData(sp, id, by.x = "pkey")
spectraVariables(sp)

spectra(mse) <- sp

mse

## ------------------------------
## Exploring a subset of interest
## ------------------------------

sp_O43175 <- sp[which(sp$DatabaseAccess == "O43175")]
sp_O43175 <- setBackend(sp_O43175, MsBackendDataFrame())


sp_O43175

cmat <- compareSpectra(sp_O43175)

rownames(cmat) <-
    colnames(cmat) <- strtrim(sp_O43175$sequence, 3)

pheatmap::pheatmap(cmat)

browseSpectra(sp_O43175)

(i <- which(rownames(cmat) == "DLP"))

spectraData(sp_O43175[i])$precursorCharge
spectraData(sp_O43175[i])$precursorMz
spectraData(sp_O43175[i])$modName

plotSpectraMirror(sp_O43175[4], sp_O43175[9])
