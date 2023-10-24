class BaseUIBuilder
  include Pagy::Backend
  attr_accessor :view_context, :state, :params, :turbo_frame_id

  ENCODE = true

  def initialize(turbo_frame_id = nil)
    tailwind_support
    @state = OpenStruct.new()
    @params = OpenStruct.new()
    @turbo_frame_id = turbo_frame_id
    
    ## The .dup is critical to avoid global state
    (@@class_params[self.class] || []).each do |attr, default|
      @params.send("#{attr}=", default.dup)
    end  
    
    ## The .dup is critical to avoid global state
    (@@class_state[self.class] || []).each do |attr, default|
      @state.send("#{attr}=", default.dup)
    end
  end

  def tailwind_support
    p = __FILE__.gsub("ui_builders/base_ui_builder.rb","views/**/*.slim")
    puts '-'*80
    puts "Adding Tailwind Support"
    puts "/config/tailwind.config.js"
    puts "content: ["
    puts "   #{p.inspect}"
    puts "}"
    puts '-'*80
  end

  def before_render
  end

  def before_call
  end

  def self.param_attr(name, default: nil)
    @@class_params ||= {}
    @@class_params[self] ||= {}
    @@class_params[self][name] = default.dup
    define_method(name) do |value|
      @params.send("#{name}=",value)
    end
  end

  def self.state_attr(name, default: nil)
    @@class_state ||= {}
    @@class_state[self] ||= {}
    @@class_state[self][name] = default.dup
  end

  # Create accessors for params
  # Triggered by Rails' render call
  def render_in(view_context, &block)
    @view_context = view_context
    load_state_from_query_params
    before_call
    block.call(self) if block_given?
    before_render
    render
  end

  # Builds Query Parameters by Merging
  # into state and then merging into
  # Query Parameters
  def new_state(**hash)
    merged_state = @state.to_h.merge(hash)
    ts = turbo_state.dup
    ts[@turbo_frame_id] = merged_state
    query_params = request.query_parameters.dup
    if ENCODE
      query_params['turbo_state'] = Base64.encode64(ts.to_json)
    else
      query_params['turbo_state'] = ts.to_json
    end
    query_params
  end

  protected

  def capture(&block)
    @view_context.capture(&block)
  end

  def request
    @view_context.request
  end

  private

  # By Convention We Render Using a Partial
  # in the app/views/turbo_components directory
  def render
    @view_context.render "ui_builders/#{builder_path}", this: self, turbo_frame_id: @turbo_frame_id, state: @state, params: @params
  end

  # By Convention We Use the Builder Class Name
  # but without the Builder suffix
  def builder_path
    self.class.name.delete_suffix("UIBuilder").underscore
  end

  def turbo_state
    turbo_state_base64 = request.query_parameters['turbo_state']
    if turbo_state_base64      
      begin
        if ENCODE
          turbo_state_json = Base64.decode64(turbo_state_base64)
        else
          turbo_state_json = turbo_state_base64
        end
        turbo_state = JSON.parse(turbo_state_json)
      rescue
        turbo_state = {}
      end
    else
      turbo_state = {}
    end
    turbo_state
  end

  def turbo_frame_state
    turbo_state[@turbo_frame_id] || {}
  end

  # Loads State from Query Parameters
  def load_state_from_query_params
    tfs = turbo_frame_state
    state_attributes.each do |attr|
      if tfs.key?(attr.to_s)
        @state.send("#{attr}=",tfs[attr.to_s])
      end
    end
  end

  def state_attributes
    @@class_state[self.class]&.keys || []
  end

  def param_attributes
    @@class_params[self.class]&.keys || []
  end

end
