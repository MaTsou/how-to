### Use own javascript code

#### Introduction
The good way to go is to use `Stimulus`. It is a tiny javascript framework 
which is a part of `Hotwire` project. `Turbo` is another part of `Hotwire` 
which is totally integrated in Rails.

So `Stimulus` is completely compatible with `Turbo`. Then when turbo-links are 
followed, stimulus code is automatically reloaded as expected. Loading 
javascript in another way leads to the risk of loading only on page redirection 
but not on turbo-stream event.

All `Stimulus` controller codes are automatically loaded. No need to `pin` 
something inside `importmap.rb` nor import something in 
`app/javascript/application.js`

#### Using Stimulus
##### The principle
`Stimulus` provide a way to identify clearly the html tag to be focused on 
together with a clear way to specify action to be triggered. So we define an 
instance of `Stimulus#controller` to be linked with a html container.

> Note : a `Stimulus#controller` has nothing to do with rails controllers !

Inside this html container, we define targets as html tags to be read or write 
together with a html tag that trigger the action.

##### The realisation
```
<!-- html code -->
<div data-controller="my_name">
  <span data-my_name-target="dest">hello world</span>
  <input id="plouf" name="plaf" data-action="input->my_name#my_function"
  data-my_name-target="source">
  <button data-my_name-target="button"
  data-action="click->my_name#my_other_function">blabla</button>
</div>
```
```
// Stimulus controller code
// app/javascript/controllers/my_name.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "dest", "source", "button" ]

    my_function() {
        this.destTarget.innerHTML = this.sourceTarget.value;
    };

    my_other_function() {
        console.log('it works !');
  };
}
```
