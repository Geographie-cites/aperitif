##############################
# Shiny App: Postcar Explicatif
# Server
##############################

shinyServer(function(input, output, session) {
  
  # outputs ----
  
  output$mapvis <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(provider = "CartoDB.DarkMatter") %>% 
      fitBounds(lng1 = 1.44, lat1 = 48.12, lng2 = 3.55, lat2 = 49.24)
  })
  
  output$mapsyn <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(provider = "CartoDB.DarkMatter") %>% 
      fitBounds(lng1 = 1.44, lat1 = 48.12, lng2 = 3.55, lat2 = 49.24)
  })
  
  output$mapflu <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(provider = "CartoDB.DarkMatter") %>% 
      fitBounds(lng1 = 1.44, lat1 = 48.12, lng2 = 3.55, lat2 = 49.24)
  })
  
  output$mappot <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(provider = "CartoDB.DarkMatter") %>% 
      fitBounds(lng1 = 1.44, lat1 = 48.12, lng2 = 3.55, lat2 = 49.24)
  })
  
  # output$grapoma <- renderPlotly({
  #   ggplotly(PomaPlot(tabsum = pomaTable, mod = input$synmod))
  # })
  
  output$grapoma <- renderPlot({
    PomaPlot(tabsum = pomaTable, mod = input$synmod)
  })
  
  output$textint <- renderText({
    req(input$aspques)
    intText <- listCondor[[paste0("INT", input$aspques)]]
    return(paste0("<strong>", intText, "</strong>"))
  })
  
  output$textmod <- renderText({
    req(input$aspques)
    modTab <- listCondor[[paste0("MOD", input$aspques)]]
    textNummod <- paste0("<strong>", substr(modTab$intitule, 1, 2), "</strong>")
    textIntmod <- substr(modTab$intitule, 4, 200)
    modTot <- paste(textNummod, textIntmod, sep = " ")
    modCollapse <- paste(modTot, collapse = "<br/>")
    return(modCollapse)
  })
  
  output$condorplot <- renderPlot({
    req(input$aspques)
    condMat <- listCondor[[input$aspques]]
    condPlot <- DrawCondorcet(condMat)
    return(condPlot)
  })
  
  
  # observers ----
  
  observeEvent(input$vis1_descr, {
    showModal(modalDialog(
      title = "Description",
      includeHTML("coat/vis1_descr.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis1_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      includeHTML("coat/vis1_exemp.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis1_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      includeHTML("coat/vis1_donne.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis2_descr, {
    showModal(modalDialog(
      title = "Description",
      includeHTML("coat/vis2_descr.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis2_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      includeHTML("coat/vis2_exemp.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis2_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      includeHTML("coat/vis2_donne.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis3_descr, {
    showModal(modalDialog(
      title = "Description",
      includeHTML("coat/vis3_descr.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis3_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      includeHTML("coat/vis3_exemp.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis3_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      includeHTML("coat/vis3_donne.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis4_descr, {
    showModal(modalDialog(
      title = "Description",
      includeHTML("coat/vis4_descr.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis4_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      includeHTML("coat/vis4_exemp.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis4_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      includeHTML("coat/vis4_donne.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis5_descr, {
    showModal(modalDialog(
      title = "Description",
      includeHTML("coat/vis5_descr.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis5_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      includeHTML("coat/vis5_exemp.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis5_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      includeHTML("coat/vis5_donne.html"),
      easyClose = TRUE,
      footer = NULL
    ))
  })

  
  observe({
    codCom <- coordCom$CODGEO[coordCom$LIBGEO == input$viscom]
    oneCom <- st_centroid(pomaCom[pomaCom$CODGEO == codCom, ])
    leafletProxy("mapvis") %>%
      clearShapes() %>% clearMarkers() %>% 
      addPolygons(data = DrawVis(), color = "grey", weight = 1, fill = TRUE, fillColor = c("black", "white"), fillOpacity = 0.3) %>% 
      addCircleMarkers(data = oneCom, stroke = FALSE, fill = TRUE, radius = 8, fillOpacity = 0.8, fillColor = "firebrick")
  })
  
  observe({
    varCarto <- paste0("CLASS", input$synmod)
    colPal <- c("tan3", "chartreuse4", "firebrick", "goldenrod")
    FctPal <- colorFactor(palette = colPal, levels = c("0_0", "0_1", "1_0", "1_1"), na.color = "transparent")
    leafletProxy("mapsyn") %>%
      clearShapes() %>% 
      addPolygons(data = pomaCom, stroke = TRUE, weight = 0.5, color = "grey", fill = TRUE, fillColor = ~FctPal(eval(parse(text = varCarto))), fillOpacity = 0.4, label = pomaCom$LIBGEO)
  })
  
  observe({
    topDes <- GetTopLinks()
    leafletProxy("mapflu") %>%
      clearShapes() %>%
      addPolygons(data = topDes$POLYG, label = topDes$POLYG$LIBGEO, stroke = TRUE, weight = 1, color = "grey35", fill = TRUE, fillColor = "ghostwhite", fillOpacity = 0.3) %>% 
      addPolylines(data = topDes$LINES, color = "firebrick", opacity = 0.8, weight = 1.5, stroke = TRUE)
  })
  
  observe({
    if(input$pottyp == "dif"){
      leafletProxy("mappot") %>%
        clearImages() %>% clearShapes() %>% clearControls() %>% 
        addRasterImage(x = SelecPotential(), colors = PotentialPalette(SelecPotential()), opacity = 0.4) %>% 
        addLegend(position = "topright", 
                  colors = c("#B22222", "#E5E5E5", "#000080"), 
                  labels = c("Surplus d'emplois (déficit d'actifs)", 
                             "Équilibre actifs-emplois",
                             "Surplus d'actifs (déficit d'emplois)"))
    } else if(input$pottyp == "ori"){
      leafletProxy("mappot") %>%
        clearImages() %>% clearShapes() %>% clearControls() %>% 
        addRasterImage(x = sqrt(SelecPotential()), colors = PotentialPalette(sqrt(SelecPotential())), opacity = 0.4) %>%
        addPolygons(data = DrawContour(), stroke = TRUE, fill = FALSE, color = "#a9a9a9", weight = 1, 
                    label = paste(as.character(round(DrawContour()$center^2)), "actifs")) %>% 
        addLegend(position = "topright", 
                  colors = c("#B22222", "#E5E5E5"),  
                  labels = c("Forte densité d'actifs", 
                             "Faible densité d'actifs"))
    } else {
      leafletProxy("mappot") %>%
        clearImages() %>% clearShapes() %>% clearControls() %>% 
        addRasterImage(x = sqrt(SelecPotential()), colors = PotentialPalette(sqrt(SelecPotential())), opacity = 0.4) %>%
        addPolygons(data = DrawContour(), stroke = TRUE, fill = FALSE, color = "#a9a9a9", weight = 1, 
                    label = paste(as.character(round(DrawContour()$center^2)), "emplois")) %>% 
        addLegend(position = "topright", 
                  colors = c("#B22222", "#E5E5E5"),  
                  labels = c("Forte densité d'emplois (destination)", 
                             "Faible densité d'emplois (destination)"))
    }
  })
  
  
  
  # functions ----
  
  SelecPotential <- reactive({
    req(input$pottyp, input$potcat)
    if(input$potcat %in% c("femm", "homm")){
      keyRas <- paste(input$pottyp, input$potcat, "tout", "tout", sep = "_")
    } else if (input$potcat %in% c("agri", "arti", "cadr", "inte", "empl", "ouvr")){
      keyRas <- paste(input$pottyp, "tout", input$potcat, "tout", sep = "_")
    } else if (input$potcat %in% c("vp", "tc")){
      keyRas <- paste(input$pottyp, "tout", "tout", input$potcat, sep = "_")
    } else {
      keyRas <- paste(input$pottyp, "tout", "tout", "tout", sep = "_")
    }
    oneRaster <- listPotentials[[keyRas]]
    return(oneRaster)
  })
  
  DrawContour <- reactive({
    potCont <- PotentialContour(ras = sqrt(SelecPotential()))
    return(potCont)
  })
  
  GetOneCoord <- reactive({
    req(input$viscom)
    oneCoord <- GetTime(tabcoords = coordCom, 
                        tabtime = listTimes[[input$vismod]], 
                        ref = input$visref, 
                        oneunit = coordCom$CODGEO[coordCom$LIBGEO == input$viscom])
    return(oneCoord)
  })
  
  GetTopLinks <- reactive({
    req(input$fluref, input$fluvar, input$flucom, input$fluthr)
    topLinks <- GetLinks(tabnav = tabFlows, spcom = pomaCom, ref = input$fluref, mod = input$flumod, varsort = input$fluvar, oneunit = input$flucom, thres = input$fluthr)
    return(topLinks)
  })
  
  DrawVis <- reactive({
    req(input$visthr)
    contVis <- DrawVisibleZone(ras = listPotentials[[1]], onetime = GetOneCoord(), thres = input$visthr)
    return(contVis)
  })
  
  DrawPoma <- reactive({
    req(input$synmod)
    varCarto <- paste0("CLASS", input$synmod)
    selPoma <- pomaCom
    return(contVis)
  })
  
  
})

