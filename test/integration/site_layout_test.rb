require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
test "check layout" do

get root_path
assert_template "static_page/home"
assert_select "a[href=?]",root_path
assert_select "a[href=?]",help_path
assert_select "a[href=?]",about_path, count:0

end
end
