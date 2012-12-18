require 'rubyfx-dialogs'

require 'jrubyfxml'

class DemoApp < FXApplication
  def start(stage)
    RubyFXDialog.alert(:info, "This is an info dialog Title", "This is an Info dialog, notice the nice I? Please click Ok now." + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!" +
        "This is an Info dialog, notice the nice I? Please click Ok now. " + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!")
    RubyFXDialog.info("And it still work!", "This is another way to specify an info dialog")
    RubyFXDialog.warn("Be careful", "But be careful, monsters lurk.")
    RubyFXDialog.error("And if you have a fatal error", "...then you can scream OH NOES! I broke the universe! Sorry :(")
    RubyFXDialog.alert(:evil_type, "You must use the provided types", "Invalid types default to :info")
  end
end

DemoApp.launch
