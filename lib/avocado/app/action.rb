module Avocado
  module Actions
    class Action
      attr_accessor :name
      attr_accessor :component
      attr_accessor :default
    end

    def initialize
      @name ||= 'Action'
      @component ||= ''
    end

    def render_response
      {
        id: id,
        name: name,
        # fields: fields,
        component: component,
        # filter_class: self.class.to_s,
      }
    end

    def id
      self.class.name.underscore.gsub('/', '_')
    end
  end
end
