Description
===========

Installs Virtualbox on OS X, Debian/Ubuntu or Windows.

Changes
=======

## v0.7.2:

* Update OS X installer to use new pkg format - thanks josephholsten.

## v0.7.0:

* Add Windows support
* No more "open source edition" - extension pack must now be downloaded
  separately from Oracle.
* Optionally install PHP web porta.

## v0.6.0:

* Install via Sun's package archive in Ubuntu
* Optionally install open-source edition from the Ubuntu repository
* Tested in Ubuntu 11.04

## v0.5.0:

* initial version, tested on OSX only

Requirements
============

## Platform:

* Mac OS X
* Ubuntu and Debian, 64 bit (amd64/x86\_64)
* Windows

Other platforms can be used but you'll need to modify the default recipe.

## Cookbooks

You'll also need the respective package manager cookbook for your platform:

* dmg (for OS X installation)
* apt (for Ubuntu and Debian)

Attributes
==========

## Mac OS X

The source file in the URL for VirtualBox's download mirror is inconsistent between different OS releases, so this cookbook smashes the URL together with a few attributes, and some string concatenation in the recipe. Sorry about that. You can always assign the URL if you know which file you want through the "url" attribute, and the recipe will do the right thing, though by default this attribute is an empty string.

The following attributes are used to build up the full source URL:

* `node['virtualbox']['urlbase']` - Base URL through the directory on the VirtualBox mirror. Default is on virtualbox.org's mirror, in the 4.0.8 directory.
* `node['virtualbox']['version']` - This is the base virtualbox file name up through the version. Slightly misleading, but there you have it.
* `node['virtualbox']['arch']` - Used to determine which architecture in the filename, for Ubuntu/Debian distributions.

Otherwise, you can specify this one, perhaps in your role:

* `node['virtualbox']['url]` - The full URL of the virtualbox download. Use this if you want to specify a particular file to download. Default is an empty string. If this is a non-empty string, the recipe will attempt to use it as the download source.

## Ubuntu

The versioning in Ubuntu is slightly different - it's just the version suffix on
the package name (e.g. virtualbox-4.0). The cookbook attributes of interest are:

* `node['virtualbox']['version']` - the version suffix of the package name,
    `virtualbox-X.X`. Valid options at the moment are "3.2" and "4.0"
* `node['virtualbox']['open_source_edition']` - If false, adds Sun's repositroy
    and installs the proprietary version (with extended USB support, among other
    things)

Usage
=====

Include the virtualbox default recipe in a role run list. If you want to install from a different source URL, provide it with the url attribute, such as:

    name "role_for_vbox"
    default_attributes("virtualbox" => { "url" => "http://url.to/your/vbox.pkg" })
    run_list("recipe[virtualbox]")

Contributions
======

The source for this cookbook is hosted on
[GitHub](https://github.com/peplin/virtualbox-cookbook). If you have any issues
with this cookbook, please follow up there.

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
