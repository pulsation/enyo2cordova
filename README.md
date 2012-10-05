Goals
=====

Developing hybrid mobile applications implies checking they work as expected on target platforms as often as possible, in order to avoid unpleasant surprises. Even though various emulators exist, they would not replace a real device’s behaviour and performance.

The idea here is to make deployment easier on real devices to ease debugging.

Short term
----------

Original focus is the possibility to deploy enyo 2 based applications directly to devices, or emulators when it's not possible directly.

Enyo 2 is a lightweight HTML5 mobile framework that can produce reasonably sized and optimized applications, while keeping common sense in mind. You can find an enyo tutorial here: [http://dailyjs.com/2012/09/20/enyo-1/](http://dailyjs.com/2012/09/20/enyo-1/)

Cordova allows deployment of HTML5 applications directly to a mobile device, and provides a set of APIs to access native functions directly from JavaScript.

Long term
---------

A background goal would be to transpose - when necessary - tasks that do not need to be executed at runtime to the upstream build phase, in order to save resources. An example would be translation tasks.

Modularity, in order to let a door to other frameworks open, is also kept in mind.

Design
------

This project consists in a set of scripts that wrap tools already provided by frameworks it depends on. Dependancies are directly managed using git submodules.

* bin/ contains initialization and deployment scripts.
* config/ contains configuration files.
* projects/enyo contains the project based on enyo if imported from git. By default, it is a modified version of the [enyo bootplate](https://github.com/enyojs/enyo/wiki/Bootplate).
* projects/android contains the cordova generated project for android (ios target will come come later).

Implemented features
====================

Version 0.1 simply focuses on deploying enyo based projects to android. More to come later.

How to use
==========

Dependencies
------------
The [android SDK](http://developer.android.com/sdk/index.html), [apache ant](http://ant.apache.org/), and [node.js](http://nodejs.org/) are mandatory.

Installation
------------
Clone from github:
    git clone https://github.com/pulsation/enyo2cordova.git

Configure parameters:
If you want to use an external project, edit the html5-project.conf and set HTML5\_PROJECT\_LOCATION to your enyo project's location and set HTML5\_PROJECT\_SCM to "none".
You can also set the android target by editing mobile-targets.conf and changing CORDOVA\_ANDROID\_VERSION.

Once done, you can initialize the dependancies by running 
    bin/init.sh 

Usage
-----

Just plug your device in and run 
    bin/deploy.sh
