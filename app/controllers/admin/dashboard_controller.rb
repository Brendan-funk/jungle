class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'].to_s, password: ENV['ADMIN_PASSWORD'].to_s
  def show
    @product_count = Product.count(:all)
    @category_count = Category.count(:all)
  end
end
