##############################
# Shiny App: Postcar Explicatif
# User interface
##############################


shinyUI(fluidPage(
  theme = "darkGrey.css",
  titlePanel("Apérit-IF : explorations introductives sur les mobilités en Île-de-France",
             tags$head(tags$link(rel = "icon", type = "image/png", href = "favicon.png"),
                       tags$title("Apérit-IF"))),
  
  tabsetPanel(
    
    # Guide ----
    
    tabPanel("Guide d'utilisation", 
             fluidRow(
               column(2),
               column(7, includeMarkdown("coat/README.md")))),
    
    # Réseau ----
    
    tabPanel("Visibilité",
             fluidRow(
               column(3, wellPanel(
                 selectInput("viscom", 
                             label = "Choisir une commune",
                             choices = sort(coordCom$LIBGEO),
                             selected = ""),
                 radioButtons("visref", label = "Origine ou destination", choices = c("Origine" = "ORI", "Destination" = "DES"), selected = "ORI"),
                 radioButtons("vismod", label = "Mode de transport", choices = c("TC" = "TC", "VP matin" = "VPM", "VP soir" = "VPS"), selected = "TC"),
                 sliderInput("visthr", label = "Seuil temporel", min = 15, max = 120, step = 15, value = 60),
                 tags$br(),
                 actionButton("vis1_descr", "Description"),
                 tags$br(),
                 actionButton("vis1_exemp", "Clés de lecture"),
                 tags$br(),
                 actionButton("vis1_donne", "Détails techniques")
                 
               )),
               column(9, leafletOutput("mapvis", height = "800px"))
             )
    ),
    
    
    tabPanel("Vitesses",
             fluidRow(
               column(4, wellPanel(
                 radioButtons("synmod", label = "Mode de transport", 
                              choices = c("TC" = "TC", "VP matin" = "VPM", "VP soir" = "VPS"), 
                              selected = "TC"),
                 tags$br(),
                 actionButton("vis2_descr", "Description"),
                 tags$br(),
                 actionButton("vis2_exemp", "Clés de lecture"),
                 tags$br(),
                 actionButton("vis2_donne", "Détails techniques")
               ),
               # plotlyOutput("grapoma", width = "100%")),
               plotOutput("grapoma", width = "100%")),
               column(8, 
                      leafletOutput("mapsyn", height = "800px")
               )
             )
    ),
    
    
    # flux ----
    
    tabPanel("Flux",
             fluidRow(
               column(3, wellPanel(
                 selectInput("flucom", 
                             label = "Choisir une commune",
                             choices = sort(coordCom$LIBGEO),
                             selected = ""),
                 radioButtons("fluref", label = "Origine ou destination", choices = c("Origine" = "ORI", "Destination" = "DES"), selected = "ORI"),
                 radioButtons("flumod", label = "Mode de transport", choices = c("Tous modes" = "TOUT", "TC" = "TC", "VP" = "VP"), selected = "TOUT"),
                 radioButtons("fluvar", label = "Quantité", choices = c("Nombre d'individus" = "FLOW", "Cumul de distance" = "DISTTOT"), selected = "FLOW"),
                 sliderInput("fluthr", label = "Top", min = 2, max = 100, step = 1, value = 3),
                 tags$br(),
                 actionButton("vis3_descr", "Description"),
                 tags$br(),
                 actionButton("vis3_exemp", "Clés de lecture"),
                 tags$br(),
                 actionButton("vis3_donne", "Détails techniques")
                 
               )),
               column(9, leafletOutput("mapflu", height = "800px"))
             )
    ),
    
    
    # Structure ----
    
    tabPanel("Bassins",
             fluidRow(
               column(3, wellPanel(
                 radioButtons("pottyp", 
                              label = "Type de potentiel", 
                              choices = c("Origine" = "ori", "Destination" = "des", "Différentiel" = "dif"), 
                              selected = "ori"),
                 radioButtons("potcat",
                              label = "Catégorie de population", 
                              choices = c("Tout" = "tout", 
                                          "Femme" = "femm", 
                                          "Homme" = "homm",
                                          "Agriculteur" = "agri", 
                                          "Artisan-commerçant" = "arti", 
                                          "Prof. supérieure" = "cadr",
                                          "Prof. intermédiaire" = "inte",
                                          "Employé" = "empl",
                                          "Ouvrier" = "ouvr",
                                          "Automobiliste" = "vp", 
                                          "Transporté collectivement" = "tc"),
                              selected = "tout"),
                 tags$br(),
                 actionButton("vis4_descr", "Description"),
                 tags$br(),
                 actionButton("vis4_exemp", "Clés de lecture"),
                 tags$br(),
                 actionButton("vis4_donne", "Détails techniques")
               )),
               column(9, leafletOutput("mappot", height = "800px"))
             )
    ),
    
    tabPanel("Aspirations", 
             fluidRow(column(3,
                             wellPanel(selectInput("aspques", 
                                                   label = "Choisir une question",
                                                   choices = c("Rythme de vie" = "Q8",
                                                               "Vie professionnelle" = "Q10",
                                                               "Organisation des transports" = "Q12",
                                                               "Contraintes" = "Q14",
                                                               "Idéal de mobilité" = "Q16"),
                                                   selected = "",
                                                   width = "100%"),
                                       tags$br(),
                                       actionButton("vis5_descr", "Description"),
                                       tags$br(),
                                       actionButton("vis5_exemp", "Clés de lecture"),
                                       tags$br(),
                                       actionButton("vis5_donne", "Détails techniques"))),
                      column(6, 
                             tags$h1(" "),
                             htmlOutput("textint"),
                             tags$hr(),
                             htmlOutput("textmod"),
                             tags$hr(),
                             plotOutput("condorplot"))
             )
    )
  )
))