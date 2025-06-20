<style>
.rule {
  display: block;
  text-align: center;
  box-shadow: 1px 1px 3px 1px #ccc;
}
</style>
## Keep control with Wordpress

### First rule
**Use a theme that do not change anything !**

A lot a themes changes the interface. Under the hood, they constrain the 
behaviour. Some, for example, disallow template customization. Others (Divi) do 
not allow custom blocks in template definition.

So I have to use a standard theme (Twentytwentyfive for now) and customize for 
my needs.

<span class="rule">
Choose Twentytwentyfive theme
</span>

### Second rule
To prevent overrides on theme updates, better is to use a child theme.

<span class="rule">
Use a child theme
</span>

##### folder structure
When files are created, they could be updated from Wordpress : 
'Tools/edit-theme-files'
```
wp-content/
  |_themes/
    |_ twentytwentyfive/
    |_ my-custom-theme/
      |_functions.php
      |_style.css # mandatory file
      |_css/
        |_ my-css1.css
      |_ templates
      |_ parts
      |_ patterns
```

<div style="page-break-before: always;"></div>
##### style.css code
```
/**
 * Theme Name: My Custom Theme
 * Template: twentytwentyfive # parent theme folder name
 * Version: 1.2.4 # useful to force cache reloading on updates !
 * ...
 */
@import url('css/my-css1.css?ver=1.2.4'); // update version here too
```

##### functions.php
Important file if style.css not only defines child theme but contains code 
(like @import..)
```
<?php
  function load_my_styles() {
    wp_enqueue_style(
      'my-custom-theme-style', # my-custom-theme is a slug (choose one)
      get_stylesheet_uri('style.css'),
      array(),
      wp_get_theme()->get('Version') # adding version to file url
    );
  }

  add_action('wp_enqueue_scripts', 'load_my_styles' );
?>
```

<div style="page-break-before: always;"></div>
### Third rule
<span class="rule">
Defining patterns and template in files limits db access on page build !
</span>

##### custom templates or template parts
These are 'modèles' or 'éléments de modèles'. They live in `.html` files under 
`templates/` or `parts/` folders. Hey they are really well named : you can't 
insert parts in a page !

<span class="rule">
If they have parent theme template names, they « override » them.
</span>

They contains html code with, as comments, wordpress directives. To build them 
one can use Gutenberg Editor and, then, turn to 'show code', copy it and paste 
into the file.

> 'show code' comes as an option when you click on '3 points' at the up right 
> corner of the editor.
```

##### custom patterns
These are 'compositions'. They live in `.php` files under `patterns/` folder.

They need a header to be recognised by Gutenberg.

```
<?php
/**
 * Title: Public Name
 * Slug: my-custom-theme/my-pattern
 * Categories: services, featured, ... # optional
 * ...
 */
?>
below, html from editor...
```
