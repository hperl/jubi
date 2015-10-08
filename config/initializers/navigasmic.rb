class CustomListBuilder < Navigasmic::Builder::ListBuilder
  def structure_for(label, link = false, options = {}, &block)
    raise
  end
end

Navigasmic.setup do |config|
  # Setting the Default Builder:
  #
  # By default the  is used unless otherwise specified.
  #
  # You can change this here:
  #config.default_builder = SemanticUiBuilder


  # Configuring Builders:
  #
  # You can change various builder options here by specifying the builder you want to configure and the options you
  # want to change.
  #
  # Changing the default ListBuilder options:
  config.builder Navigasmic::Builder::ListBuilder do |builder|
    builder.wrapper_class = ''
    builder.wrapper_tag = :ul
    builder.has_nested_class = 'has-dropdown'
    builder.is_nested_class = 'dropdown'

    builder.label_generator = proc{ |label, _, _, _| label }
  end
end
