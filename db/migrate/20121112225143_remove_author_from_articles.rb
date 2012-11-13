class RemoveAuthorFromArticles < ActiveRecord::Migration
  def self.up
    remove_column(:articles, :author)
  end

  def self.down
    add_column(:articles, :author, :string)
  end
end
