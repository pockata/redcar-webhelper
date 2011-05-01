
# require 'webkit'

module Redcar
    class WebHelper
        class Browser

            attr_reader :window, :wv

            def initialize url, w, h

                # Make a window & resize it
                @window = Gtk::Window.new
                @window.resize(w, h)

                # Create some stuff
                @scroll = Gtk::ScrolledWindow.new
                @progress = Gtk::ProgressBar.new
                @wv = Gtk::WebKit::WebView.new
                @text = Gtk::Entry.new
                @go = Gtk::Button.new 'Go!'

                # Open the url
                @wv.open url

                # Run everything
                self.run
            end

            def run

                # Create some more stuff
                vbox = Gtk::VBox.new
                hbox = Gtk::HBox.new
                tb = Gtk::Toolbar.new

                # Fill the toolbar
                tb.toolbar_style = Gtk::Toolbar::Style::ICONS
                tb.append(Gtk::Stock::GO_BACK) { @wv.go_back }
                tb.append(Gtk::Stock::GO_FORWARD) { @wv.go_forward }
                tb.append(Gtk::Stock::STOP) { @wv.stop_loading }
                tb.append(Gtk::Stock::REFRESH) { @wv.reload }
                tb.append(Gtk::Stock::HOME) {  }

                self.connectSignals

                # Pack 'em up
                hbox.pack_start tb, false
                hbox.pack_start @text
                hbox.pack_start @go, false
                vbox.pack_start hbox, false
                vbox.pack_start @scroll
                vbox.pack_start @progress, false

                @scroll.add @wv
                @window.add vbox
                @window.show_all
            end

            # Connecting the signal handlers
            def connectSignals

                @wv.signal_connect('load-finished') do |view, frame|
                    @text.text = @wv.uri
                    @progress.set_visible false
                end

                @wv.signal_connect('load-started') do |view, frame|
                    @progress.set_visible true
                end

                @go.signal_connect('clicked') do |btn|
                    @wv.open @text.text
                end

                @wv.signal_connect('title-changed') do |view, frame, page_title|
                    new_title = "#{page_title} - WebHelper"
                    @window.set_title new_title if @window.title != new_title
                end

                @wv.signal_connect('load-progress-changed') do |webview, amount|
                    @progress.set_fraction(amount/100.0)
                end
            end
        end
    end
end

# Redcar::WebHelper::Browser.new 'http://google.com', 500, 300
# Gtk.main