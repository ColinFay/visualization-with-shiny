## ui.R ##

shinyUI(
  function(request) {
    dashboardPage(
      skin = styles$skin_color,
      theme = styles$css_files,
      sidebar_mini = FALSE,
      
      dashboardHeader(
        title = "OTS beta dashboard"
      ),
      
      dashboardSidebar(
        sidebarMenu(
          # Controls ----------------------------------------------------------------
          
          sliderInput(
            "y",
            "Years:",
            min = available_years_min,
            max = available_years_max,
            value = c(available_years_max - 4, available_years_max),
            sep = "",
            step = 1,
            ticks = FALSE

          ),
          
          selectInput(
              "r",
              "Reporter:",
              choices = available_reporters_iso[available_reporters_iso != "all"],
              selected = "usa",
              selectize = TRUE
            ),
          
            selectInput(
              "p",
              "Partner:",
              choices = available_reporters_iso,
              selected = "all",
              selectize = TRUE
            ),
          
          actionButton("go", "Go!")
        )
      ),
      
      dashboardBody(
        fluidRow(
          useShinyjs(),
          
          div(
            id = "contents",
            
            # Title -------------------------------------------------------------------
            
            column(
              12,
              htmlOutput("title", container = tags$p),
              htmlOutput("title_legend", container = tags$i)
            ),
            
            # Trade -------------------------------------------------------------------
            
            column(
              12,
              htmlOutput("trade_subtitle", container = tags$h2),
              htmlOutput("trade_paragraph", container = tags$p),
              br(),
              highchartOutput("trade_exchange_bars_aggregated", height = "500px"),
              htmlOutput("url_trade")
            ),
            
            # Exports -----------------------------------------------------------------
            
            column(
              12,
              htmlOutput("exports_subtitle", container = tags$h2),
              htmlOutput("exports_paragraph", container = tags$p),
              br()
            ),
            
            column(
              6,
              highchartOutput("exports_treemap_detailed_min_year", height = "500px"),
              htmlOutput("url_exports_min_year")
            ),
            
            column(
              6,
              highchartOutput("exports_treemap_detailed_max_year", height = "500px"),
              htmlOutput("url_exports_max_year")
            ),
            
            # Imports -----------------------------------------------------------------
            
            column(
              12,
              htmlOutput("imports_subtitle", container = tags$h2),
              htmlOutput("imports_paragraph", container = tags$p),
              br()
            ),
            
            column(
              6,
              highchartOutput("imports_treemap_detailed_min_year", height = "500px"),
              htmlOutput("url_imports_min_year")
            ),
            
            column(
              6,
              highchartOutput("imports_treemap_detailed_max_year", height = "500px"),
              htmlOutput("url_imports_max_year")
            ),
            
            # URL and download buttons ------------------------------------------------
            
            hidden(
              div(
                id = "share_download_cite",
                column(
                  12,
                  htmlOutput("share_download_cite_subtitle", container = tags$h2),
                  br()
                ),
                
                column(
                  12,
                  htmlOutput("url"),
                  br(),
                  br()
                ),
                
                column(
                  12,
                  selectInput(
                    "format",
                    "Download data as:",
                    choices = available_formats,
                    selected = NULL,
                    selectize = TRUE
                  ),
                  
                  downloadButton("download_aggregated", "Aggregated data"),
                  downloadButton("download_detailed", "Detailed data"),
                  
                  br(),
                  br()
                ),
                
                column(
                  12,
                  htmlOutput("cite_subtitle", container = tags$h3),
                  htmlOutput("cite", container = tags$p),
                  htmlOutput("cite_bibtex_subtitle", container = tags$h3),
                  verbatimTextOutput("cite_bibtex")
                )
              )
            )
          ),
          
          # Loading ----------------------------------------------------------------
          
          hidden(
            div(
              id = "loading",
              img(src = "img/loading_icon.gif", width = "100"),
              p("Loading..."),
              align = "center"
            )
          ),
          
          # Footer ------------------------------------------------------------------
          
          p("Open Trade Statistics, 2019.", style = "color:#f9fafb"),
          
          tags$footer(
            tags$link(rel = "shortcut icon", href = "img/favicon.ico"),
            tags$script(src = "js/copy-url.js")
          )
        )
      )
    )
  }
)
