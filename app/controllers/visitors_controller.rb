class VisitorsController < ApplicationController
  def index
    @toys = Toy.order('id DESC').last(6)
  end
end
