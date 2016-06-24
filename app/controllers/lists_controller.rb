class ListsController < ApplicationController
  include PaginationHelper
  RECORDS_PER_PAGE = 10
  def services_with_reports
    @services = Service.list_services_with_reports
    @services = paginate_services(@services, RECORDS_PER_PAGE, params[:page])
  end
end
