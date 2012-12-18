require "RubyFXDialogs/version"
require "jrubyfxml"

class RubyFXDialog < FXController
  fx_id :messageLabel
  fx_id :icon
  fx_id :detailsLabel
  fx_id :okButton
  fx_id :cancelButton
  fx_id :buttonRow
  
  def initialize(type, title, message, details="", options={}, stage)
    @type = type
    @details = details
    @message = message
    stage.title = title
    @stage = stage
    @options = options
    # can't set the message label because its not injected yet...
  end
  
  def close_with_status(status)
    @result = status
    @stage.close
  end
  
  fx_handler :ok do
    close_with_status :ok
  end
  
  fx_handler :cancel do
    close_with_status :cancel
  end
  
  def show
    unless @options[:buttons] == nil
      @buttonRow.children.remove_all  @okButton, @cancelButton
      @options[:buttons].each do |desc, value|
        # Create the new button
        btn = build(Button, text: desc, min_width: 80,
          cancel_button: @options[:cancel] == value, 
          default_button: @options[:default] == value)
        
        # add it to the panel
        @buttonRow.children.add *if [(@options[:left] || [])].flatten.include? value
          [0, btn]
        else
          [btn]
        end
        
        # Set the margin and on click
        HBox.set_margin btn, Java.javafx.geometry.Insets.new(0,0,0,16)
        btn.set_on_action do
          close_with_status value
        end
        btn.request_focus if @options[:default] == value
      end
    else
      @okButton.request_focus
    end
    @messageLabel.text = @message
    @detailsLabel.text = @details unless @detailsLabel == nil
    @type = :info if ![:info,:warn,:error,:question].include?(@type.to_sym)
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
  
  def self.prompt(type, title, message, details="", options={})
    stage = Stage.new
    RubyFXDialog.load_fxml("res/OkCancelDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [type, title, message, details, options, stage]).show
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
