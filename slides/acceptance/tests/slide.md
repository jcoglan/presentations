!SLIDE title
# Tests?


!SLIDE
# Culerity

    Scenario: See default error message
      Given the Article class validates acceptance of terms
      When I visit "/articles/new"
      And I focus the "Terms" check box
      And I focus the "Save" button
      Then I should see "Terms must be accepted"


!SLIDE
# Cross-process metaprogramming

```ruby
Given /^the (\S+) class validates (\S+) of (\S+)$/ do
|class_name, validation, field|
  inject_code class_name,
    "validates_#{validation}_of :#{field}"
end
```

!SLIDE
# Hacking the model

```ruby
VALIDATION_CONFIG = File.dirname(__FILE__) +
                    '/../../config/validation/'

FileUtils.mkdir_p(VALIDATION_CONFIG)

def inject_code(class_name, code)
  file = class_name.tableize.singularize
  File.open(VALIDATION_CONFIG + file + '.rb', 'a') do |f|
    f.write <<-CODE
      class #{class_name}
        #{code}
      end
    CODE
  end
end
```

!SLIDE
# Hacking the model

```ruby
# app/models/article.rb

class Article < ActiveRecord::Base
  extend Acceptance::ReflectsOnValidations
  attr_accessor :terms, :password_confirmation
end

path = File.dirname(__FILE__) + '/../../config/validation/article.rb'
load path if File.file?(path)
```

!SLIDE commandline
# Get the code

    $ git clone git://github.com/jcoglan/acceptance.git

