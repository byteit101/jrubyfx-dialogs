require 'rubyfx-dialogs'

require 'jrubyfxml'

class DemoApp < FXApplication
  def start(stage)
    RubyFXDialog.alert_modal(:info, "This is an Info dialog, notice the nice I? Please click Ok now." + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!" +
        "This is an Info dialog, notice the nice I? Please click Ok now. " + 
        "This Dialog is very long. You might want nice short dialogs so they are readable, but if you have "+
        "Long ones also that is fine, as it will, as you may already see, wrap its self to fit the dialog!", "This is an info dialog")
  end
end

DemoApp.launch
