require_relative '00_attr_accessor_object.rb'

class MassObject < AttrAccessorObject

  def self.my_attr_accessible(*new_attributes)
    new_attributes = new_attributes.map(&:to_sym)
    self.attributes.concat(new_attributes)
  end

  def self.attributes
    if self == MassObject
      raise "must not call #attributes on MassObject directly"
    end

    @attributes ||= []
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      # column names
      if self.class.attributes.include?(attr_name)
        self.send("#{attr_name}=", value)
      else
        raise "unknown attribute: #{ attr_name }"
      end
    end
  end
end
