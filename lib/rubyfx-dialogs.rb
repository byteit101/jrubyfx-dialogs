require "RubyFXDialogs/version"
require "jrubyfxml"

class RubyFXDialog < FXController
  fx_id :messageLabel
  fx_id :icon
  fx_id :detailsLabel
  fx_id :okButton
  fx_id :cancelButton
  
  def initialize(type, title, message, details="", buttons=nil, stage)
    @type = type
    @type = :info if ![:info,:warn,:error,:question].include?(type.to_sym)
    @details = details
    @message = message
    stage.title = title
    @stage = stage
    @buttons = buttons
    # can't set the message label because its not injected yet...
  end
  
  fx_handler :ok do
    @result = :ok
    @stage.close
  end
  
  fx_handler :cancel do
    @result = :cancel
    @stage.close
  end
  
  def show
    unless @buttons == nil
      @okButton.text = @buttons[0] #bad
      @cancelButton.text = @buttons[1] # bad
    end
    @messageLabel.text = @message
    @detailsLabel.text = @details unless @detailsLabel == nil
    @icon.center = RubyFXDialog.load_fxml_resource("res/dialog-#{@type}.fxml", nil, __FILE__)
    with(@stage, :resizable => false) do
      initModality Java.javafx.stage.Modality::APPLICATION_MODAL
      sizeToScene
      centerOnScreen
      showAndWait
    end
    @result || :ok
  end
  
  def self.alert(type, title, description)
    stage = Stage.new
    RubyFXDialog.load_fxml("res/AlertDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [type, title, description, "", stage]).show
  end
  
  def self.prompt(type, title, message, details="")
    stage = Stage.new
    RubyFXDialog.load_fxml("res/OkCancelDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [type, title, message, details, stage]).show
  end
  
  def self.dialog(icon_name, title, message, details, buttons)
    stage = Stage.new
    RubyFXDialog.load_fxml("res/OkCancelDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [icon_name, title, message, details, buttons, stage]).show
  end
  
  class << self
    [:info,:warn,:error].each do |type|
      self.instance_eval do
        # define the handy overloads that just pass our arguments in
        define_method(type) do |description, title|
          alert(type, description, title)
        end
      end
    end
  end
end
