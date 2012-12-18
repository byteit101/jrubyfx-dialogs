require "RubyFXDialogs/version"
require "jrubyfxml"

class RubyFXDialog < FXController
  fx_id :messageLabel
  fx_id :icon
  
  def initialize(type, description, title, stage)
    @type = type
    @description = description
    stage.title = title
    @stage = stage
    # can't set the message label because its not injected yet...
  end
  
  fx_handler :ok do
    @stage.close
  end
  
  def show
    # run_later do # run on proper thread!
    @messageLabel.text = @description
    @icon.center = RubyFXDialog.load_fxml_resource("res/Dialog-info.fxml", nil, __FILE__)
    @stage.resizable = false
    @stage.sizeToScene
    @stage.centerOnScreen
    @stage.showAndWait
    #end
  end
  
  def self.alert_modal(type, description, title=nil)
    stage = Stage.new
    RubyFXDialog.load_fxml("res/AlertDialog.fxml", stage, :relative_to => __FILE__, :initialize => [type, description, title, stage]).show
  end
end
