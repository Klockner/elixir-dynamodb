defmodule MetricsDynamoDB.MapReduceScan do
  alias ExAws.Dynamo

  def call(table_name, column_name, value) do
    result = Dynamo.scan(table_name,
      expression_attribute_values: [value: value],
      filter_expression: "#{column_name} > :value"
    ) |> ExAws.request!

    %{"Count" => count} = result
    count
  end
end
