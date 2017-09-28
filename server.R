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
    textIntmod <- substr(modTab$intitule, 4, 100)
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
      HTML("L'analyse de <strong>visibilité</strong> doit se comprendre comme métaphore des jeux vidéos dans lesquels le 
           terrain de jeux est initialement obscurci (<em>terra incognita</em>) et apparait au fur et à mesure de 
           son exploration. Pour une commune, un mode de transport et un temps de transport, la zone de 
           visibilité est définie comme la zone accessible (desserte). Les matrices de temps de transport 
           sont riches d'enseignement parce qu'elles portent une information sur la structure du réseau 
           d'infrastructure mais aussi sur la structure des flux."),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis1_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      HTML("<ul>
<li>Au départ d'Argenteuil, en voiture à l'heure de pointe du matin (VPM), avec un temps de transport maximum de 45 minutes, 
la zone de visibilité s'étend à tout le Nord-Ouest de l'Île-de-France jusqu'aux frontières de l'Oise. En revanche, cette zone 
s'arrête au Nord du périphérique parisien et Paris dans son ensemble reste inaccessible.</li>
<li>Avec les mêmes paramètres (VP matin, temps de 45 mn) mais à destination d'Argenteuil, Paris fait partie de la zone de visibilité. 
Ceci est une illustration de la structure des flux, centripète le matin et centrifuge le soir : les Argenteuillais ne peuvent 
pas accéder à Paris en voiture le matin en moins de 45 minutes, alors que les Parisiens peuvent accéder à Argenteuil 
dans ces mêmes conditions.</li>
      </ul></li>"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis1_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      HTML("<ul>
<li>Les données utilisées sont les matrices de temps de transport entre zones, en transport en commun (TC), en véhicule 
particulier à l'heure de pointe du matin (VPM) et à l'heure de pointe du soir (VPS).</li>
<li>Le zonage de la DREIA-IF (zonage du modèle de prévision MODUS) est transféré dans le zonage communal francilien 
(1300 communes et arrondissements). Les zones MODUS sont très fines dans Paris et très vastes en grande couronne, le transfert du 
zonage MODUS au zonage communal permet une bonne approximation des temps de transport dans toute la zone dense de Paris et de la 
petite couronne (départements 75, 92, 93, 94). En revanche, dans les communes peu denses de grande couronne, l'estimation des temps 
de transport est imprécise.</li> 
<li>Les zones d'accessibilité sont calculées à partir des matrices de temps par interpolation avec une moyenne pondérée par 
la distance (<em>Inverse Distance Weighted</em>).</li>
</ul></li>"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis2_descr, {
    showModal(modalDialog(
      title = "Description",
      HTML("L'analyse des <strong>vitesses</strong> consiste à calculer pour chaque commune le temps moyen d'accès vers toutes les 
autres communes et la vitesse moyenne d'accès vers toutes les autres communes d'Île-de-France. Cette analyse est tirée des travaux 
de Karel Martens qui considère que la vitesse moyenne d'accès à l'ensemble de la ville donne un 
&quot;index de mobilité potentielle&quot; (<em>PMI - Potential Mobility Index</em>). 
La vitesse moyenne d'accès, ou PMI, a l'intérêt d'être indépendante de la position de la commune dans l'espace d'étude, ce qui n'est 
pas le cas du temps moyen d'accès. Une commune en bordure de la région aura une accessibilité faible (temps moyen d'accès important) 
parce qu'elle est loin de toutes les autres, alors qu'une commune située au centre de la région aura une accessibilité forte 
(temps moyen d'accès faible). Cette différence est due uniquement à la situation de la commune. En revanche la vitesse moyenne 
d'accès sera comparable pour ces deux communes indépendemment de leur situation au sein de la région."),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis2_exemp, {
    showModal(modalDialog(
      title = "Clés de lecture",
      HTML("<ul>
<li>Il y a une relation faible entre PMI (vitesse moyenne) et accessibilité (temps moyen). Pour le VP les résultats reflètent 
à la fois la structure du réseau et la structure des flux (congestion). Cette relation est plutôt positive : plus le temps moyen est 
élevé, plus la vitesse moyenne est élevée. Les communes de grande couronne par exemple sont éloignées de l'ensemble des autres 
communes (temps moyen élevé) mais on y circule à grande vitesse. À l'inverse, les communes du centre de l'agglomération sont 
proches de l'ensemble de la région (temps moyen faible) mais les vitesses de circulation sont faibles. Pour le TC, les résultats 
reflètent uniquement la structure du réseau et la relation est négative : plus le temps moyen est élevé plus la vitesse moyenne est 
faible. Les communes du centre de l'agglomération sont bien connectées à l'ensemble de la région par le réseau de transport public, 
elles sont à la fois proches de l'ensemble et bénéficient de vitesses rapides. À l'inverse, les communes de grande couronne 
(à l'exception de certains points du réseau de RER et Transilien comme Meaux ou Melun) sont éloignées de l'ensemble tout en 
subissant des vitesses moyennes faibles.</li>
<li>La mise en relation de l'accessibilité et de la vitesse forme un cadre d'analyse intéressant (<em>POMA framework</em>, voir 
les travaux de Martens) : il met en avant les communes fragiles du point de vue de l'accessibilité (en rouge : communes 
éloignées des autres avec des vitesses faibles) et les communes gagnantes (en vert : communes proches des autres avec des 
vitesses élevées).</li>
</ul></li>"),
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  observeEvent(input$vis2_donne, {
    showModal(modalDialog(
      title = "Données et méthodes",
      HTML("<ul>
<li>Les données utilisées sont les matrices de temps de transport entre zones, en transport en commun (TC), en véhicule particulier 
à l'heure de pointe du matin (VPM) et à l'heure de pointe du soir (VPS).</li>
<li>Le zonage de la DREIA-IF (zonage du modèle de prévision MODUS) est transféré dans le zonage communal francilien (1300 communes 
et arrondissements). Les zones MODUS sont très fines dans Paris et très vastes en grande couronne, le transfert du zonage MODUS au 
zonage communal permet une bonne approximation des temps de transport dans toute la zone dense de Paris et de la petite couronne 
(départements 75, 92, 93, 94). En revanche, dans les communes peu denses de grande couronne, l'estimation des temps de transport 
est imprécise.</li>
<li>Le graphique représente la position des communes selon leur vitesse moyenne et leur temps moyen d'accès, les cadrants sont 
définis par la médiane de chacune des deux variables.</li>
</ul></li>"),
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
      addPolygons(data = pomaCom, stroke = TRUE, weight = 0.5, color = "grey", fill = TRUE, fillColor = ~FctPal(eval(parse(text = varCarto))), fillOpacity = 0.4, popup = pomaCom$LIBGEO)
  })
  
  observe({
    topDes <- GetTopLinks()
    leafletProxy("mapflu") %>%
      clearShapes() %>%
      addPolygons(data = topDes$POLYG, popup = topDes$POLYG$LIBGEO, stroke = TRUE, weight = 1, color = "grey35", fill = TRUE, fillColor = "ghostwhite", fillOpacity = 0.3) %>% 
      addPolylines(data = topDes$LINES, color = "firebrick", opacity = 0.8, weight = 1.5, stroke = TRUE)
  })
  
  observe({
    if(input$pottyp == "dif"){
      leafletProxy("mappot") %>%
        clearImages() %>% clearShapes() %>%
        addRasterImage(x = SelecPotential(), colors = PotentialPalette(SelecPotential()), opacity = 0.4)
    } else {
      leafletProxy("mappot") %>%
        clearImages() %>% clearShapes() %>%
        addRasterImage(x = SelecPotential(), colors = PotentialPalette(SelecPotential()), opacity = 0.4) %>%
        addPolygons(data = DrawContour(), stroke = TRUE, fill = FALSE, color = "#a9a9a9", weight = 1, popup = as.character(round(DrawContour()$center)))
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
    potCont <- PotentialContour(ras = SelecPotential())
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

