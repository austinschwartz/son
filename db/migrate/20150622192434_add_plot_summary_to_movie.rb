class AddPlotSummaryToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :plot_summary, :string
  end
end
