class JournalsController < ApplicationController
  before_action :set_show_values
  before_action :find_journal, only: [:show, :edit, :update]

  def index
    @journals = Journal.order(:name).paginate(page: params[:page], per_page: 30)
  end

  def show
    @publication_count = @journal.articles.count
    sift_categories(@journal)
  end

  def edit
  end

  def update
    new_attrs = journal_params
    new_attrs[:display_name] = nil if new_attrs[:display_name] == @journal.name || new_attrs[:display_name] == ""
    @journal.update_attributes(new_attrs)
    redirect_to journal_path
  end

  def affinities
    @journal = Journal.find(params[:journal_id])
    @affinities = Affinity.for(@journal).includes(:journal_one).includes(:journal_two).compact.reject{ |a| a.affinity.nan? }.sort_by(&:affinity).reverse
  end

  private

  def find_journal
    @journal = Journal.includes(:publications).includes(:authors).find(params[:id])
  end

  def set_show_values
    @focused = "Data"
    @focused_datatype = "Journals"
  end

  def journal_params
    params.require(:journal).permit(:name, :publication_start, :publication_end, :display_name)
  end
end