class ReportsController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end
end