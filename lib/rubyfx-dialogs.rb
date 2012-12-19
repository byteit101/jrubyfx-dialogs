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

require "jrubyfxml"

class RubyFXDialog < FXController
  # register all our fx:id's
  fx_id :messageLabel, :icon, :detailsLabel, :okButton, :cancelButton, :buttonRow
  
  def initialize(type, title, message, details="", options={}, stage)
    @type = type
    @details = details
    @message = message
    stage.title = title
    @stage = stage
    @options = options
    # can't set the message label because its not injected yet...
  end
  
  # Call this to close the dialog
  def close_with_status(status)
    @result = status
    @stage.close
  end
  
  # register the ok and cancel handlers to close
  fx_handler [:ok, :cancel] do |event|
    close_with_status event.target == @okButton ? :ok : :cancel
  end
  
  def show
    # do we have custom buttons?
    unless @options[:buttons] == nil
      # if so, remove the standard ones
      @buttonRow.children.remove_all  @okButton, @cancelButton
      @options[:buttons].each do |desc, value|
        # Create the new button
        btn = build(Button, text: desc, min_width: 80,
          cancel_button: @options[:cancel] == value, 
          default_button: @options[:default] == value)
        
        # add it to the panel, checking if its in the left list or not
        @buttonRow.children.add *if [(@options[:left] || [])].flatten.include? value
          [0, btn] # if it in the left list, insert it at position 0
        else
          [btn]
        end
        
        # Set the margin and on click
        HBox.set_margin btn, Insets.new(0,0,0,16)
        btn.set_on_action do
          close_with_status value
        end
        btn.request_focus if @options[:default] == value
      end
    else
      # set the default button the default :)
      @okButton.request_focus
    end
    # update our labels
    @messageLabel.text = @message
    @detailsLabel.text = @details unless @detailsLabel == nil
    # sanity check
    @type = :info if ![:info,:warn,:error,:question].include?(@type.to_sym)
    # load the icon
    @icon.center = RubyFXDialog.load_fxml_resource("res/dialog-#{@type}.fxml", nil, __FILE__)
    # Set properties on the stage
    with(@stage, :resizable => false) do
      initModality Modality::APPLICATION_MODAL
      sizeToScene
      centerOnScreen
      showAndWait # show, and this will not return until stage.close in the event handlers
    end
    # return our results
    @result || :ok
  end
  
  # For single message dialogs, just alert
  def self.alert(type, title, description)
    stage = Stage.new
    RubyFXDialog.load_fxml("res/AlertDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [type, title, description, "", stage]).show
  end
  
  # for multi-option prompts, we have more options
  def self.prompt(type, title, message, details="", options={})
    stage = Stage.new
    RubyFXDialog.load_fxml("res/OkCancelDialog.fxml", stage, 
      :relative_to => __FILE__, 
      :initialize => [type, title, message, details, options, stage]).show
  end
  
  # alias alerts
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
