defmodule MetricsDynamoDB.CreateEntry do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]

  alias ExAws.Dynamo

  def call do
    Dynamo.create_table("Users", "email", %{email: :string}, 1, 1)
    |> ExAws.request!
  end
end
