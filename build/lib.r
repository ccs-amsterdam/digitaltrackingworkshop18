sink_file <- function(x, filename='index.html') {
  sink(filename)
  cat(x)
  sink()
  filename
}

readtxt <- function(fn) readChar(fn, file.info(fn)$size)

build_html <- function(title, author, date, city, country, byline, logo, image, url, intro, prepare, participants_lead, location, google_maps, sponsors, footer, github) {
  a = as.list(environment())
  
  html = readtxt('build/index_template.html')
  for (i in seq_along(a)) {
    html = gsub(paste0('{', toupper(names(a)[i]), '}'), a[[i]], html, fixed = T)
  }
  sink_file(html, 'index.html')
}


build_css <- function(top_button_col='#27ae60', top_button_border_col='#27ae60', intro_col='#183244', intro_bg_col='#ABBECD', body_col='#34495e', a_col='#2980b9', prepare_col=intro_col, prepare_bg_col=intro_bg_col) {
  a = as.list(environment())
  
  css = readtxt('build/css_template.css')
  for (i in seq_along(a)) {
    css = gsub(paste0('{', toupper(names(a)[i]), '}'), a[[i]], css, fixed = T)
  }
  sink_file(css, 'style/main.css')
}
