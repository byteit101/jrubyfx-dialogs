require 'rubyfx-dialogs'

require 'jrubyfxml'

class DemoApp < FXApplication
  def start(stage)
    RubyFXDialog.alert_modal(:info, "This is an Info dialog, notice the nice I? Please click Ok now.", "This is an info dialog")
  end
end

DemoApp.launch
