class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.string :name
      t.string :desc
      t.string :photo # For Carrierwave
      t.references :gallery

      t.timestamps
    end
    add_index :gallery_photos, :gallery_id
  end
end
