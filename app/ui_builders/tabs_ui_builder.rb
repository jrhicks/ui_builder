class TabsUIBuilder < BaseUIBuilder
  state_attr :selected_tab_title, default: nil
  param_attr :tabs, default: []
    
  def tab(title, badge=nil, &block)
    if @state.selected_tab_title.nil?
      @state.selected_tab_title = title
    end
    
    @params.tabs << OpenStruct.new(
      title: title,
      content: lambda { capture(&block) },
      selected: title == @state.selected_tab_title,
      badge: badge
    )
  end

  def selected_tab
    @params.tabs.find { |t| t.selected }
  end

end
