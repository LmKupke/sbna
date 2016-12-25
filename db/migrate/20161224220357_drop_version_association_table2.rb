class DropVersionAssociationTable2 < ActiveRecord::Migration
  def up
    drop_table :version_associations
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
