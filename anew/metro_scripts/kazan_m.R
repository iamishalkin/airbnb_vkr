setwd('~/anew/aparts')
source('funcs.R')
city = 'Kazan.csv'

metro = 'metro.csv'
city_centre <- c(49.1155156, 55.7974548)  #Казанский кремль

metro = read.csv(metro, encoding = 'UTF-8')
codes <- metro %>% distinct(city_id, .keep_all = TRUE)
metro_id = 'Казань'

df = read.csv(city)
df <- df %>% distinct(apart_id, .keep_all = TRUE)

metro <- metro %>% filter(operator == metro_id)
metro <- metro %>% mutate(lat = as.numeric(as.character(lat)),
                          lon = as.numeric(as.character(lon)))
df <- df %>% price_per_night(.) %>% 
  lng_to_lon(.) %>% 
  #hmanyrooms(.) %>% 
  filter(property_type != 'Хостел')

df$to_centre=NA
for (i in 1:nrow(df)){
  df$to_centre[i]=distm (c(df$lon[i],df$lat[i]), city_centre, fun = distHaversine)
}

df_wm=add_metro_dist(df, metro)
path = paste0('~/m_', city)
write.csv(df_wm,file=path, row.names = F)