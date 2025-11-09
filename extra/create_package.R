# create the colorize package
# From: https://kbroman.org/AdvData/18_rpack_demo.html
#

library(usethis)

# package skeleton
create_package("C:/Dropbox/R/projects/colorize")

use_git()

use_mit_license("Michael Friendly")

use_readme_rmd()


# create GitHub repo
use_github()

use_news_md()

use_vignette("colorbox", "Illustrating colorbox")
