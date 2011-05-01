
Plugin.define do
  name    "WebHelper"
  version "0.1"
  file    "lib", "webhelper.rb"
  object  "Redcar::WebHelper"
  dependencies "application",">0",
               "ruby"       ,">0"
end
