require "RubyFXDialogs/version"
require "jrubyfxml"

class RubyFXDialog < FXController
  fx_id :messageLabel
  fx_id :icon
  
  def initialize(type, title, description, stage)
    @type = type
    @type = :info if ![:info,:warn,:error,:debug].include?(type.to_sym)
    @description = description
    stage.title = title
    @stage = stage
    # can't set the message label because its not injected yet...
  end
  
  fx_handler :ok do
    @stage.close
  end
  
  def show
    @messageLabel.text = @description
    @icon.center = RubyFXDialog.load_fxml_resource("res/dialog-#{@type}.fxml", nil, __FILE__)
    with(@stage, :resizable => false) do
      initModality Java.javafx.stage.Modality::APPLICATION_MODAL
      sizeToScene
      centerOnScreen
      showAndWait
    end
  end
  
  def self.alert(type, title, description)
    stage = Stage.new
    RubyFXDialog.load_fxml("res/AlertDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [type, title, description, stage]).show
  end
  
  class << self
    [:info,:warn,:error,:debug].each do |type|
      self.instance_eval do
        # define the handy overloads that just pass our arguments in
        define_method(type) do |description, title|
          alert(type, description, title)
        end
      end
    end
  end
end
