require 'rubyfx-dialogs'

require 'jrubyfxml'

class DemoApp < FXApplication
  def start(stage)
    RubyFXDialog.alert(:info, "This is an Info dialog, notice the nice I? Please click Ok now." + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!" +
        "This is an Info dialog, notice the nice I? Please click Ok now. " + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!", "This is an info dialog Title")
    RubyFXDialog.info("This is another way to specify an info dialog", "And it still work!")
    RubyFXDialog.warn("But be careful, monsters lurk.", "Be careful")
    RubyFXDialog.error("...then you can scream OH NOES! I broke the universe! Sorry :(", "And if you have a fatal error")
  end
end

DemoApp.launch
