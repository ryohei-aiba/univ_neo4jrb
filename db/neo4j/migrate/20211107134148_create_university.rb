class CreateUniversity < Neo4j::Migrations::Base
  def up
    add_constraint :University, :uuid
  end

  def down
    drop_constraint :University, :uuid
  end
end
