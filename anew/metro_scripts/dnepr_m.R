setwd('~/anew/aparts')
source('funcs.R')
city = 'Dnepr.csv'

metro = 'metro.csv'
city_centre <- c(35.0463296, 48.4656392) #ЦУМ

metro = read.csv(metro, encoding = 'UTF-8')
metro <- metro %>% mutate(lat = as.numeric(as.character(lat)),
                          lon = as.numeric(as.character(lon)))
codes <- metro %>% distinct(city_id, .keep_all = TRUE)
metro_id = "Днепропетровск"

df = read.csv(city)
df <- df %>% distinct(apart_id, .keep_all = TRUE)

metro <- metro %>% filter(operator == metro_id)

df <- df %>% price_per_night(.) %>% 
  lng_to_lon(.) %>% 
  #hmanyrooms(.) %>% 
  filter(property_type != 'Хостел')
  #inspect()

df$to_centre=NA
for (i in 1:nrow(df)){
  df$to_centre[i]=distm (c(df$lon[i],df$lat[i]), city_centre, fun = distHaversine)
}

df_wm=add_metro_dist(df, metro)
path = paste0('~/m_', city)
write.csv(df_wm,file=path, row.names = F)
