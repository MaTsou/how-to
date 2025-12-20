## How to use bundle
Here I want to save how `bundle update` works.

First of all, I think `bundle update` strict command do not have to be used. 
Always accompany it with dedicated options.

A version is supposed to respect the following format :

`v.major.minor.patch`

+ `--conservative` update only Gemfile listed gems.
+ `--major` (default) update gems to the last released version.
+ `--minor` update gems to the last minor update.
+ `--patch` update gems to the last patch update.
+ `--strict` garanty that the `major`, `minor`, and `patch` options will be 
  strictly respected. In fact, these options only re-order the list of 
  available versions; `--strict` remove unmatched versions from the list.

Rem : changing `Gemfile` and running `bundle install` will always perform
`update --conservative` under the hood.

`bundle update [OPTIONS] my_gem` will restrict its job to `my_gem` ; BUT, 
without `--conservative`, this could imply dependancies update and can cause 
dammages if some of these dependancies are shared with other gems..

Some people say that version restriction are not necessary in Gemfile since 
`--patch` and `--minor` options can be specified on `bundle update`. They may 
be right. However, `< x.y.z` could be a safe way to prevent unwanted updates.
