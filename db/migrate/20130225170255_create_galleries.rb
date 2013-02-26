class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :desc
      t.belongs_to :galleriable, :polymorphic => true

      t.timestamps
    end
  end
end
