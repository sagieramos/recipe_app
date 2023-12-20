class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? || value.empty?

    return if contains_required_characters?(value)

    record.errors[attribute] << (options[:message] || default_error_message)
  end

  private

  def contains_required_characters?(value)
    contains_uppercase = /[A-Z]/
    contains_lowercase = /[a-z]/
    contains_number = /[0-9]/
    contains_special = /[^A-Za-z0-9]/

    value =~ contains_uppercase &&
      value =~ contains_lowercase &&
      value =~ contains_number &&
      value =~ contains_special
  end

  def default_error_message
    'must contain at least one uppercase letter, ' \
      'one lowercase letter, one number, and one special character'
  end
end
