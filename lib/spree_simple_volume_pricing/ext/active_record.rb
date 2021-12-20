module ActiveRecord::Persistence
  # Update attributes of a record without callbacks, validations etc.
  def update_attributes_without_callbacks(attributes)
    debugger

    self.send(:attributes=, attributes)
    self.class.update_all(attributes) if id
  end
end
