defmodule MetricsDynamoDB.GetItem do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]

  alias ExAws.Dynamo

  def call do
    result = Dynamo.get_item("Users", %{email: "bubba@foo.com"})
    |> ExAws.request!
  end
end
