
#
# Before 'facepalm-ing' while looking the code below, look at the Readme.md file! :D
#

# The default include paths for Ruby 1.8
# Default_paths = ["/usr/lib/ruby/site_ruby/1.8", "/usr/lib/ruby/site_ruby/1.8", "/usr/lib/ruby/site_ruby/1.8/i386-linux", "/usr/lib/ruby/site_ruby", "/usr/lib/ruby/site_ruby", "/usr/lib/site_ruby/1.8", "/usr/lib/site_ruby/1.8/i386-linux", "/usr/lib/site_ruby", "/usr/lib/ruby/1.8", "/usr/lib/ruby/1.8", "/usr/lib/ruby/1.8/i386-linux", "."]

# Default_paths.each do |path|
	
# 	$LOAD_PATH.push path
# end

require 'webkit'
require 'browser'


# Default_paths.each do |path|
# 	
#	$LOAD_PATH.each_index do |index|
# 		if $LOAD_PATH[index] == path
# 			$LOAD_PATH.delete_at(index)
# 		end
# 	end
# end

module Redcar

    class WebHelper
        def initialize

            # Load the storage
            @storage = Plugin::Storage.new('WebHelper')
            @storage.set_default('default', [
                'url' => 'http://google.com',
                'width' => 400,
                'height' => 280
            ])

            # Make some bindings
            self.menus
            self.keymaps
        end

        # Shows the menu in the toolbar
        def self.menus
            Redcar::Menu::Builder.build do
                sub_menu "Plugins" do
                    sub_menu "WebHelper" do
                        item "Show window", OpenWebHelper
                        item "Edit WebHelper", EditWebHelper
                    end
                end
            end
        end

        # Makes the keybindings
        def self.keymaps
            map = Redcar::Keymap.build("main", [:osx, :linux, :windows]) do
                link "Alt+W", OpenWebHelper
            end
            [map]
        end
		
		# Open WebHelper's directory as a project
		class EditWebHelper < Redcar::Command
			def execute
				
				Project::Manager.open_project_for_path(
					File.join(Redcar.user_dir, "plugins", "webhelper")
				)
				
				tab = Redcar.app.focussed_window.new_tab(Redcar::EditTab)
				mirror = Project::FileMirror.new(
					File.join(Redcar.user_dir, "plugins", "webhelper", "lib", "webhelper.rb")
				)
				tab.edit_view.document.mirror = mirror
				tab.edit_view.reset_undo
				tab.focus
			end
		end
    
        # Shows the WebHelper window
        class OpenWebHelper < Redcar::Command
            def execute

                # Get the current project object
                project = Project::Manager.in_window(win)

                # Got an object?
                unless project.nil?
                    # Yep, get it's path
                	path = project.path
                else
                    # Nope, use the default
                    path = "default"
                end

                # Does it exist in storage?
                @props = @storage['default'] unless @props = @storage[path]

                # Start the browser
                Browser.new(@props['url'], @props['width'], @props['height'])
            end
        end
    end
end
