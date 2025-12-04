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
      |_ shortcodes
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

#### Add category support for pages
```
# functions.php
function add_categories_to_pages() {
  register_taxonomy_for_object_type('category', 'page');
}

add_action( 'init', 'add_categories_to_pages' );
```
#### Register custom shortcodes
```
# functions.php
function uss_shortcodes_init(){
  include 'shortcodes/my_first_shortcode.php';
}

add_action('init', 'uss_shortcodes_init');
```
```
# shortcodes/my_first_shortcode.php
<?php
/**
 * [activities] returns the current activities layout
 * @return html content
*/


######################################################################
function uss_activities() {
  $args = array(
    "perPage" => 1, "pages" => 0, "offset" => 0,
    "post_type" => "page", # could be "post" !!
    "category_name" => "activite", # slug here
    "order" => "ASC", "orderby" => "date", "author" => "",
    "search" => "", "exclude" => [], "sticky" => "", "inherit" => false,
    "parents" => []
  );
  $the_query = new WP_Query( $args );

  // The Loop.
  ob_start();
  if ( $the_query->have_posts() ) {
    wrap($the_query);
  } else {
    esc_html_e( 'Sorry, no posts matched your criteria.' );
  }
  // Restore original Post Data.
  wp_reset_postdata();
  return ob_get_clean();
}
add_shortcode( 'activities', 'uss_activities' );

######################################################################
# private functions
function wrap($query) {
	echo "<div class='activity-wrapper'>";
	loop_over($query);
	echo "</div>";
}

function loop_over($query) {
  while ( $query->have_posts() ) {
    $query->the_post();
    $the_ID = get_the_ID();
    
    $icon_name = esc_attr(get_post_meta($the_ID, 'icon-name', true));
    $title = esc_html(get_the_title());
    $link = esc_url(get_the_permalink());
    $desc = esc_html(get_post_meta($the_ID, 'description', true));
    $color = get_post_meta($the_ID, 'main-color', true);
    
    card_html($icon_name, $title, $desc, $link, $color);
  }
}

function card_html($icon_name, $title, $desc, $link, $color) {
  echo <<<HTML
    <div class='activity-card'>
      <i class='fas fa-$icon_name'></i>
      <h2 class='wp-block-heading' style='color: $color'>$title</h2>
      <p>$desc</p>
      <div class='wp-block-buttons'>
        <div class='wp-block-button'>
          <a class='wp-block-button__link wp-element-button' href='$link'>En savoir plus..</a>
        </div>
      </div>
    </div>
HTML;
}
/** Always end your PHP files with this closing tag */
?>
```
