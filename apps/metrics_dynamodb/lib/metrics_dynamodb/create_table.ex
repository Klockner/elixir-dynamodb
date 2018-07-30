defmodule MetricsDynamoDB.CreateTable do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]

  alias ExAws.Dynamo

  def call(table_name, primary_key) do
    ExAws.Dynamo.create_table(table_name |> String.capitalize, primary_key, %{primary_key |> String.to_atom => :string}, 1, 1)
    |> ExAws.request!
  end
end
