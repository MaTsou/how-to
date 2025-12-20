### Define custom TurboStream actions

#### Introduction
TurboStream come vith `replace`, `update`, `remove`, and a few other actions to 
be performed on turbo frames.

Some time we could be frustrated not to have an action dedicated to our current 
purpose.

Use case : need only to execute js code. In my budgetApp, on `budget_periods` 
index, a click on one `budget_period` triggers `budget_periods#set-active` 
controller action. It performs various checks then session update. The only work 
of the `set_active.turbo_stream.erb` is to toggle `active-period` class on the 
targetted turbo-frames.

#### Defining a `toggle_class` Turbo Stream action
```javascript
# app/javascript/application.js (path with a rails app !)
Turbo.StreamActions.toggle_class = function () {
  this.targetElements.for_each((target) => {
    target.classList.toggle(
      this.templateContent.textContent
    );
  });
};
```
+ `this` refers to the action.
+ `targetElements` refers to the targetted turbo-frames (a list !)
+ `this.templateContent` is the TurboStream action template (see docs)
+ `this.templateContent.textContent` refers to the content of the template.

So, in any `.turbo_stream.erb` file, I can run :
```
<%= turbo_stream.action :toggle_class, turbo_frame_dom_id, 'my-class' %>
```
to toggle 'my-class'.
