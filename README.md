Goals
=====

Developing hybrid mobile applications implies checking they work as expected on target platforms as often as possible, in order to avoid unpleasant surprises. Even though various emulators exist, they would not replace a real device’s behaviour and performance.

The idea here is to make deployment easier on real devices.

Short term
----------

This project focuses on deploying enyo 2 applications directly to cordova. 

Enyo 2 is a lightweight HTML5 mobile framework that can produce reasonably sized and optimized applications, while keeping common sense and simplicity of development in mind.

Cordova allows deployment of HTML5 applications directly to a mobile device, and provides a set of APIs to access native functions directly from JavaScript.

Long term
---------

A background goal would be to transpose - when necessary - tasks that do not need to be executed at runtime to the upstream build phase, in order to save resources. An example would be translation tasks.

Modularity, in order to let a door to other frameworks open, is also kept in mind.

Platforms
---------

For now, this set of scripts only work on Linux, to deploy on android devices. MacOS X and iphone devices are a short term target. Any other platform is of course welcome.

Design
------

This project will consist in a set of scripts that wrap tools already provided by frameworks it depends on. Dependancies are directly managed using git submodules. 

* bin/ contains initialization, deployment and update scripts.
* config/ contains configuration files.
* projects/html5/enyo contains the enyo project. By default, it is the enyo bootplate.
* projects/cordova/android contains the cordova generated project.

Implemented features
====================

For now, this project is under development, and not usable.
