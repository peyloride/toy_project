class VisitorsController < ApplicationController
  def index
    @toys = Toy.order('id DESC').first(6)
  end
end
