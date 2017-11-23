# $ mix ecto.gen.migrations add_topics
defmodule Discuss.Repo.Migrations.AddTopics do
    use Ecto.Migration

    def change do
        create table(:topics) do
            add :title, :string
        end
    end
end
