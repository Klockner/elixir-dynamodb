defmodule MetricsDynamoDB.PutItem do
  @derive [ExAws.Dynamo.Encodable]
  defstruct [:email, :name, :age, :admin]

  alias ExAws.Dynamo

  def call do
    user = %{email: "bubba@foo.com", name: "Bubba", age: 23, admin: false, palestrinha: true}
    Dynamo.put_item("Users", user) |> ExAws.request!
  end
end
