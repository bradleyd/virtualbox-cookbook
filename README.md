Description
===========

Installs Virtualbox on OS X or Debian/Ubuntu

Changes
=======

## v0.5.0:

* initial version, tested on OSX only

Requirements
============

## Platform:

* Mac OS X
* Ubuntu and Debian, 64 bit (amd64/x86_64) (untested)

Other platforms can be used but you'll need to modify the default recipe.

## Cookbooks

* dmg (for OS X installation)

Attributes
==========

The source file in the URL for VirtualBox's download mirror is inconsistent between different OS releases, so this cookbook smashes the URL together with a few attributes, and some string concatenation in the recipe. Sorry about that. You can always assign the URL if you know which file you want through the "url" attribute, and the recipe will do the right thing, though by default this attribute is an empty string.

The following attributes are used to build up the full source URL:

* `node['virtualbox']['urlbase']` - Base URL through the directory on the VirtualBox mirror. Default is on virtualbox.org's mirror, in the 4.0.8 directory.
* `node['virtualbox']['version']` - This is the base virtualbox file name up through the version. Slightly misleading, but there you have it.
* `node['virtualbox']['arch']` - Used to determine which architecture in the filename, for Ubuntu/Debian distributions.

Otherwise, you can specify this one, perhaps in your role:

* `node['virtualbox']['url]` - The full URL of the virtualbox download. Use this if you want to specify a particular file to download. Default is an empty string. If this is a non-empty string, the recipe will attempt to use it as the download source.

Usage
=====

Include the virtualbox default recipe in a role run list. If you want to install from a different source URL, provide it with the url attribute, such as:

    name "role_for_vbox"
    default_attributes("virtualbox" => { "url" => "http://url.to/your/vbox.pkg" })
    run_list("recipe[virtualbox]")

License and Author
==================

* Copyright 2011, Joshua Timberman <cookbooks@housepub.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
