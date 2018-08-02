sink_file <- function(x, filename='index.html') {
  sink(filename)
  cat(x)
  sink()
  filename
}


readtxt <- function(fn) readChar(fn, file.info(fn)$size)

embed_image <- function(fname) paste0('data:image/png;base64,', base64enc::base64encode(fname))

build_html <- function(css, title, author, date, city, country, byline, logo, image, url, intro, prepare, participants_lead, participants, location, google_maps, sponsors, footer, github) {
  a = as.list(environment())
  
  html = readtxt('build/index_template.html')
  for (i in seq_along(a)) {
    html = gsub(paste0('{', toupper(names(a)[i]), '}'), a[[i]], html, fixed = T)
  }
  sink_file(html, 'index.html')
}


create_css <- function(participants, top_button_col='#27ae60', top_button_border_col='#27ae60', intro_col='#183244', intro_bg_col='#ABBECD', body_col='#34495e', a_col='#2980b9', prepare_col=intro_col, prepare_bg_col=intro_bg_col) {
  a = as.list(environment())
  
  css = readtxt('build/css_template.css')
  for (i in seq_along(a)) {
    css = gsub(paste0('{', toupper(names(a)[i]), '}'), a[[i]], css, fixed = T)
  }
  #sink_file(css, 'style/main.css')
  css
}

participant_csv = 'participants/participants.csv'

get_images <- function(participant_csv) {
  d = read.csv(participant_csv)
  images = list.files('images/participants', full.names = T)
  
  d$name = paste(d$firstname,ds$surname)
  d$image = sapply(d$name, function(x) grep(x, images, value=T)[1])

  for (i in which(is.na(d$image))) {
    message('Downloading image of ', d$firstname[i], ' ', d$surname[i])
    ext = if (grepl('.png', d$image[i], fixed=T)) '.png' else '.jpg'
    fname = paste0('images/participants/', d$name[i], ext)
    download.file(as.character(d$image_url[i]), fname, mode = 'wb', quiet = T)
    d$image[i] = fname
  }
  d$image
}

nospace <- function(x) gsub(' ', '', x, fixed=T)

css_participants <- function(participant_csv) {
  image = get_images(participant_csv)
  name = nospace(paste0(d$firstname, '-', d$surname))
  css = paste0('.', name, ' .participant-image {background: url(', sapply(image, embed_image), ') no-repeat; background-size: cover; }')
  paste(css, collapse='\n\n')              
}

html_participants <- function(participant_csv) {
  d = read.csv(participant_csv)
  name = nospace(paste0(d$firstname, '-', d$surname))
  html = paste0('<div class="participant ', name, '">
                 <div class="participant-image"></div>\n',
                 ifelse(d$role == '', '', paste0('<div class="participant-role">', d$role ,'</div>')),
                 '<h3 class="participant-name"><a href="', d$website, '" title="About ', d$firstname, '...">', d$firstname, ' ', d$surname, '</a></h3>
                 <p class="participant-affiliation">', d$affiliation, '</a></p>
                 </div>')   
  html = tapply(html, rep(1:ceiling(length(html)/3), each=3, len=length(html)), FUN = paste, collapse='\n\n')
  html = paste('<div class="participant-row">\n', html, '\n</div>\n')
  paste(html, collapse='\n\n')
}

