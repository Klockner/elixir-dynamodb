defmodule MetricsDynamoDB.PutItem do
  alias ExAws.Dynamo

  def call(table_name, item) do
    Dynamo.put_item(table_name, item) |> ExAws.request!
  end
end
