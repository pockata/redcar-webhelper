#_WebHelper_

A small browser preview for the Redcar text editor

###Features:

 - Show webpage in a small preview window
 - Reload page on document save

Purpose:
   Useful for web developers (or just me..)

###Install

   First you need to download and install the rbwekitgtk bindings from [here](https://github.com/magec/rbwebkitgtk/)

   When you're done, download the plugin  
   `cd ~/.redcar/plugins  
   git clone git://github.com/pockata/redcar-webhelper.git webhelper`

###Run

Coming soon

###Todo
 - Add handler for document save
 - Store custom urls for projects
 - Save last loaded url and window size

###Notes
###**Read this before examening the code!**  
**First of all the plugins doesn't work (yet)** so calm down and read on.  
This is my first encounter with the terrific Ruby language.
I saw my first piece of Ruby code in about 2 days, so don't be harsh.
Next, to use this plugin, you need to install the Ruby WebKit Gtk bindings (as stated in \#Install),
but there we have a little problem. After running Redcar, it removes the default paths from $LOAD_PATH,
and my plugin can't load gtk and webkit.. I tried adding back the default paths (the first few lines in webhelper.rb), but still no luck!
If someone would fork the plugin and provide a solution, i'll be very grateful. Thanks!

