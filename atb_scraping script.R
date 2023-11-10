library(polite)
library(tidyverse)
library(rvest)
library(xml2)
library(XML)

# permission to scrape

bow("https://www.atbmarket.com/catalog") 

# prep objects

atb_web_adress <- "https://www.atbmarket.com"

parsed_website <- read_html("https://www.atbmarket.com/")
Sys.sleep(runif(1, 5.1, 6.2))

atb_catalogue <- parsed_website |> html_element(".category-menu") |> html_elements("a") |>
  html_attr("href")

# container df

cat.name <- rep(NA, 10000) 
desc <- rep(NA, 10000)
price <- rep(NA, 10000)
unit <- rep(NA, 10000)

df <- as.data.frame(cbind(cat.name, desc, price, unit))

# main loop

n <- 1 

for (i in 1:length(atb_catalogue)) {
  web_category <- paste(atb_web_adress, atb_catalogue[i], sep = "")
  parsed_category <- read_html(web_category)
    Sys.sleep(runif(1, 5.1, 6.2))
  
  max_pages <- xml_find_all(parsed_category, "/html/body/main//nav/ul") |> html_text() |>
    str_replace_all("[\r\n]" , ",") |> strsplit(",") |> unlist() |> as.numeric() |> 
    as.vector() |> last()
  
  max_pages <- ifelse((is.na(max_pages) | max_pages == 0), max_pages <- 1, max_pages) 
  
    for (p in 1:max_pages) {
      parsed_page <- read_html(paste(parsed_category, "?page=[p]", sep = ""))
      Sys.sleep(runif(1, 5.1, 6.2))
      desc <- parsed_page |> html_elements(".catalog-item__title") |> 
        html_element("a") |> html_text()
      
         if (length(desc) == 0) {
            next
          }
      
      df$desc[n:(n-1 + length(desc))] <- desc
      
      price <- parsed_page |> html_elements(".catalog-item") |> 
        html_element(".catalog-item__product-price") |> html_element("span") |> 
        html_text2()
      df$price[n:(n-1 + length(desc))] <- price
      
      unit <- parsed_page |> html_elements(".catalog-item") |> 
        html_element(".catalog-item__product-price") |> 
        html_element(".product-price__unit") |> html_text2()
      df$unit[n:(n-1 + length(desc))] <- unit
      
      df$cat.name[n:(n-1 + length(desc))] <- str_replace(web_category, 
                                                           "/catalog/", "")
      n <- n + length(unit)
      }
}

df1 <- df |> na.omit()
df1$unit <- df1$unit |> str_replace_all("/", "")
df1$cat.name <- df1$cat.name |> str_replace_all("https://www.atbmarket.com", "")

df1$time <- Sys.time()

# saving data - state you directory
setwd("C:/Your directory")

write.csv(df1, file = paste0(format(Sys.time(), "%Y.%m.%d"), " ціни АТБ", ".csv"), fileEncoding = "UTF-8")


