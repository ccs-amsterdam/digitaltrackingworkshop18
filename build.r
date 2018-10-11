source('build/lib.r')


css = create_css(participants = css_participants('participants/participants.csv'),
                 top_button_col='#0089d1',
                 top_button_border_col='#0089d1', 
                 intro_col='#FFFFFF', 
                 prepare_col = '#FFFFFF',
                 intro_bg_col='#34495e',
                 prepare_bg_col='#34495e',
                 body_col='#34495e',
                 a_col='#0089d1')

build_html(css = css,
           title = 'Digital Tracking Workshop 2018',
           author = 'Wouter van Atteveldt, Kasper Welbers and Magdalena Wojcieszak',
           date = 'October 27-28th, 2018',
           city = 'Amsterdam',
           country = 'NL',
           byline = 'Invited participants only',
           logo = embed_image('images/ccs_amsterdam.png'),
           image = 'http://ccs-amsterdam.org/wp-content/uploads/2018/03/cropped-Europe-network-1024x400.jpg',
           url = 'http://ccs.amsterdam',
           intro = readtxt('build/intro.txt'),
           prepare = readtxt('build/prepare.txt'),
           participants_lead = readtxt('build/participants_lead.txt'),
           participants = html_participants('participants/participants.csv'),
           location = readtxt('build/location.txt'),
           google_maps = google_maps(c('https://maps.google.com/maps?q=crea%20amsterdam&t=&z=13&ie=UTF8&iwloc=&output=embed', 'https://maps.google.com/maps?q=dak%20van%20amsterdam&t=&z=13&ie=UTF8&iwloc=&output=embed')),  # https://www.embedgooglemap.net/
           sponsors = readtxt('build/sponsors.txt'),
           footer = readtxt('build/footer.txt'),
           github = 'ccs-amsterdam/digitaltrackingworkshop18')


