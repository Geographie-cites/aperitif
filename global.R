##############################
# Shiny App: Postcar Explicatif
# Global
##############################


# load packages ----

library(shiny)
library(shinythemes)
library(leaflet)
library(ggplot2)
library(sp)
library(raster)
library(cartography)
library(SpatialPosition)
library(reshape2)
library(gstat)
library(sf)
library(dplyr)

# load data ----

listPotentials <- readRDS(file = "data/listpotentials.Rds")
listTimes <- readRDS(file = "data/listtimes.Rds")
coordCom <- readRDS(file = "data/coordcom.Rds")
pomaCom <- readRDS(file = "data/pomacom.Rds")
pomaTable <- readRDS(file = "data/pomatable.Rds")
tabFlows <- readRDS(file = "data/tabflows.Rds")
listCondor <- readRDS(file = "data/condorcet.Rds")


# Create color palette for potentials ----

PotentialPalette <- function(ras) {
  valRas <- c(as.matrix(ras))
  if(min(valRas, na.rm = TRUE) > 0){
    palCol <- colorRampPalette(c("grey90", "firebrick"))(100)
  } else {
    valRasMin <- min(valRas, na.rm = TRUE)
    valRasMax <- max(valRas, na.rm = TRUE)
    valRange <- c(valRasMin, valRasMax)
    seqVal <- seq(valRasMin, valRasMax, 100)
    getZero <- findInterval(0, seqVal)
    palBlue <- colorRampPalette(c("navyblue", "grey90"))(getZero)
    palRed <- colorRampPalette(c("grey90", "firebrick"))(length(seqVal)-getZero)
    palCol <- c(palBlue, palRed)
  }
  return(palCol)
}


# Create color palette for potentials ----

PotentialContour <- function(ras) {
  potCont <- rasterToContourPoly(r = ras, nclass = 15)
  potContGeo <- st_as_sf(spTransform(potCont, CRSobj = CRS("+init=epsg:4326")))
  return(potContGeo)
}


# Select spatial unit and join time values ----

GetTime <- function(tabcoords, tabtime, ref, oneunit){
  oriDes <- c("ORI", "DES")
  invRef <- oriDes[oriDes != ref]
  oneTime <- tabtime[tabtime[[ref]] == oneunit, ]
  oneTimeCoords <- tabcoords %>% left_join(oneTime, by = c("CODGEO" = invRef)) %>% filter(!is.na(VAL))
  return(oneTimeCoords)
}


# Draw visible zone with time threshold ----

DrawVisibleZone <- function(ras, onetime, thres){
  timeInterpol <- gstat(id = "VAL", formula = VAL ~ 1, locations = ~ X1 + X2, data = onetime, nmax = 10)
  rasTime <- interpolate(ras, timeInterpol, xyOnly = TRUE, xyNames = c("X1", "X2"))
  rasTime <- mask(rasTime, ras)
  valRas <- c(as.matrix(rasTime))
  valRasMax <- max(valRas, na.rm = TRUE)
  contThres <- rasterToContourPoly(r = rasTime, breaks = c(0, thres, ceiling(valRasMax)))
  contThres <- st_as_sf(spTransform(contThres, CRSobj = CRS("+init=epsg:4326")))
  return(contThres)
}


# create POMA plot ----

PomaPlot <- function(tabsum, mod){
  varx <- paste0("AVG", mod)
  vary <- paste0("PMI", mod)
  varclass <- paste0("CLASS", mod)
  tabsum <- tabsum[tabsum[[varclass]] %in% c("0_0", "0_1", "1_0", "1_1"), ]
  medx <- median(tabsum[[varx]], na.rm = T)
  medy <- median(tabsum[[vary]], na.rm = T)
  pomaPlot <- ggplot(tabsum) + 
    geom_point(aes_string(x = varx, y = vary, color = varclass), size = 1) + 
    geom_vline(xintercept = medx, color = "grey80") +
    geom_hline(yintercept = medy, color = "grey80") +
    # scale_color_manual(values = c("chartreuse4", "tan3", "goldenrod", "firebrick")) +
    scale_color_manual(values = c("tan3", "chartreuse4", "firebrick", "goldenrod")) +
    xlab(label = paste0("Temps moyen d'accès vers tout (", mod, ", mn)")) + 
    ylab(label = paste0("Vitesse moyenne d'accès vers tout (", mod, ", km/h)")) + 
    theme_darkhc
  return(pomaPlot)
}


# get top links ----

GetLinks <- function(tabnav, spcom, ref, mod, varsort, oneunit, thres){
  refLib <- paste0(ref, "LIB")
  oriDes <- paste0(c("ORI", "DES"), "LIB")
  invRef <- oriDes[oriDes != refLib]
  print(mod)
  if(mod == "TOUT"){
    tabSel <- tabnav %>% 
      group_by(ORI, DES) %>% 
      summarise(FLOW = sum(FLOW), DIST = first(DIST), DISTTOT = sum(DISTTOT), ORILIB = first(ORILIB), DESLIB = first(DESLIB)) %>% 
      as.data.frame(stringsAsFactors = FALSE)
    tabSel <- tabSel[tabSel[[refLib]] == oneunit, ]
    tabSel <- tabSel[order(tabSel[[varsort]], decreasing = TRUE), ]
  } else {
    tabSel <- tabnav[tabnav[[refLib]] == oneunit, ] 
    tabSel <- tabSel[tabSel$MODE %in% mod, ] 
    tabSel <- tabSel[order(tabSel[[varsort]], decreasing = TRUE), ]
  }
  
  nbRows <- ifelse(thres > nrow(tabSel), nrow(tabSel), thres)
  spLinks <- getLinkLayer(x = pomaCom, df = tabSel[1:nbRows, c("ORI", "DES")])
  print(spLinks)
  spPol <- spcom[spcom$CODGEO %in% spLinks$DES, ]
  topDes <- list(POLYG = spPol, LINES = spLinks)
  return(topDes)
}


# draw Condorcet matrix ----

DrawCondorcet <- function(condormat){
  condorMin <- condormat - t(condormat)
  condorBin <- ifelse(condorMin > 0, 1, ifelse(condorMin < 0, -1, 0))
  moltenCondor <- melt(condorMin, varnames = c("ORI", "DES"), value.name = "VAL")
  moltenCondor <- moltenCondor[moltenCondor$ORI != moltenCondor$DES, ]
  moltenCondor$BIN <- ifelse(moltenCondor$VAL < 0, 0, 1)
  moltenCondor$DUEL <- factor(moltenCondor$BIN, levels = c(0, 1), labels = c("Perd", "Gagne"))
  moltenCondor$ORI <- as.character(moltenCondor$ORI)
  moltenCondor$DES <- as.character(moltenCondor$DES)
  
  condorPlot <- ggplot(moltenCondor) + 
    geom_point(aes(DES, ORI, color = DUEL), size = 5) +
    scale_color_manual(values = c("dodgerblue", "firebrick")) +
    theme_darklinehc + ylab("La réponse ...") + xlab("... est préférée à ...")
  
  return(condorPlot)
}


# ggplot dark theme ----

# without lines
theme_darkhc <- theme_bw() +
  theme(plot.background = element_rect(fill = "#272B30"),
        axis.line = element_line(color = "grey80"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "#272B30"),
        axis.title = element_text(family = "sans-serif", color = "grey80"),
        axis.text = element_text(family = "sans-serif", color = "grey80"),
        axis.ticks = element_blank(),
        legend.position = "none",
        legend.background = element_rect(fill = "#272B30"))

# with lines
theme_darklinehc <- theme_bw() +
  theme(plot.background = element_rect(fill = "#272B30"),
        axis.line = element_line(color = "grey80"),
        panel.grid.major = element_line(color = "grey80", size = 0.1),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_rect(fill = "#272B30"),
        axis.title = element_text(family = "sans-serif", color = "grey80"),
        axis.text = element_text(family = "sans-serif", color = "grey80"),
        axis.ticks = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.key =  element_blank(),
        legend.text = element_text(family = "sans-serif", color = "grey80"),
        legend.background = element_rect(fill = "#272B30"))
