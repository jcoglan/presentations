!SLIDE center
# Terminus
## Script remote browsers with Capybara


!SLIDE
# Capybara internals

```ruby
                              Capybara::DSL
                                    |
                                    |
                                    V
                            Capybara::Session
                                    |
                                    |
                                    V
                        Capybara::Driver::Terminus
```

!SLIDE
# DSL >> Object Model

```ruby
                        session.click_link "Sign up!"
                                    |
                                    |
                                    V
                  /------------------------------------\
                  | xpath = '//a[text() = "Sign up!"]' |
                  | links = driver.find(xpath)         |
                  | links.first.click                  |
                  \------------------------------------/
```

!SLIDE
# Messaging

```ruby
                ruby
                /-----------------------\
                | click_link "Sign up!" |
                \-----------------------/
                        |     ^
                        |     |
                        V     |
                terminus      |           browser
                /-------------------\     /----------------\
                | Faye messaging    |<----| Run JavaScript |
                | JavaScript driver |---->| Send response  |
                \-------------------/     \----------------/
```