class ApplicationController < ActionController::Base
  def hello
    render html: "<h1>Issues</h1>".html_safe
  end
end
