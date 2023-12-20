### Configure rails to use (and auto-compile) scss files
The new rails7 release (speaking in december 2023) is dedicated to use 
`dartsass` scss processor (see github repo) :
```
bundle add dartsass-rails
rails dartsass:install
```
This create a `app/assets/stylesheet/application.scss` (so `application.css` is 
not needed anymore). To be checked : maybe I also have to run `rails 
dartsass:build` (sure in production environment !)


#### Split scss files
The `application.scss` has to import (`@import` function) all the needed scss 
files to be compilated. One thing is to be known : all the scss variables are 
scoped inside their files and aren't accessible from others. Probably the way 
it has to go : the fact is that css variables survive compilation ; scss 
variables don't.

Hence, to share a scss variable we need to explicitely import the file 
defining the variable into the file that needs it.

```
# app/assets/stylesheet/application.scss
@import "variables.scss" // relative path from app/assets/stylesheet
@import "common_layout.scss"

# app/assets/stylesheet/shared_scss_variables.scss
$scale-ratio: 1.618; // golden ratio
// useless if the variables.scss file below is the one file that defines all 
// the css variables used !

# app/assets/stylesheet/variables.scss
@import "shared_scss_variables.scss"
--radius-0: 2px;
@for $i from 1 through 3 {
  --radius-#{$i}: calc(var(--radius-#{$i - 1}) * $scale-ratio);
}
--body-color: hsl(0, 0%, 88%);

# app/assets/stylesheet/commont_layout.scss
@import "shared_scss_variables.scss"
stack-l {
  (...)
}
```

#### auto-compile in development mode
While installing dartsass, `foreman` gem is also installed together with 
`./bin/dev` and a ` forgotten name` created files in app root dir.

This feature allow to launch server and autocompile functionality in a one 
line. But it fails ! Probably because of the non-system-wide installation of 
ruby I have (the foreman gem is in ~/.rbenv/subfolders and they aren't in PATH 
variable). Work around :
```
rails dartsass:watch &
rails s
```
