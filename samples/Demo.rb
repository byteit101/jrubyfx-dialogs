=begin
RubyFX Dialogs - Useful JavaFX dialogs
Copyright (C) 2012 Patrick Plenefisch

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as 
published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

require 'rubyfx-dialogs'

class DemoApp < JRubyFX::Application
  def start(stage)
    RubyFXDialog.alert(:info, "This is an info dialog Title", "This is an Info dialog, notice the nice I? Please click Ok now." + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!" +
        "This is an Info dialog, notice the nice I? Please click Ok now. " + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!")
    # we can use the aliases
    RubyFXDialog.info("And it still work!", "This is another way to specify an info dialog")
    RubyFXDialog.warn("Be careful", "But be careful, monsters lurk.")
    RubyFXDialog.error("And if you have a fatal error", "...then you can scream OH NOES! I broke the universe! Sorry :(")
    # don't use evil aliases, they don't work :)
    RubyFXDialog.alert(:evil_type, "You must use the provided types", "Invalid types default to :info")
    # prompts need a type also, and two lines. One short message, and details
    p RubyFXDialog.prompt(:question, "How are you doing?", "Do you want to continue?", "This thing can even ask you questions!")
    p RubyFXDialog.prompt(:warning, "Don't abuse it", "Custom Dialogs are powerful", 
      "Don't take over the world",  # details
      :buttons => {"Sigh" => :sigh, "Never!" => :never, "(Evil Grin)" => :evil}, # set buttons to a hash of display text to return value
      :default => :never, :cancel => :sigh, # you can set default and cancel actions
      :left => :evil) # this is the list of nodes to be left aligned. it can be a full list
  end
end

DemoApp.launch
