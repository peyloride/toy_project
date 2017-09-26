class VisitorsController < ApplicationController
  def index
    @toys = Toy.take(6)
  end
end
