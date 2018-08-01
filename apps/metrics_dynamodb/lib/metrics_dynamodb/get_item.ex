defmodule MetricsDynamoDB.GetItem do

  defmodule Event do
    @derive [ExAws.Dynamo.Encodable]
    defstruct [:UserId, :CreatedAt]
  end

  alias ExAws.Dynamo

  def call(table_name, user_id) do
    Dynamo.get_item(table_name, %{UserId: user_id, CreatedAt: "2018-08-01 14:05:30.497889Z"})
    |> ExAws.request!
    |> Dynamo.decode_item(as: Event)
  end
end
