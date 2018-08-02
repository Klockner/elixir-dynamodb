defmodule MetricsDynamoDB.Query do
  defmodule Event do
    @derive [ExAws.Dynamo.Encodable]
    defstruct [:UserId, :CreatedAt]
  end

  defmodule UserWebSession do
    @derive [ExAws.Dynamo.Encodable]
    defstruct [:UserId, :CreatedAt, :UpdatedAt, :WebSessionNumber]
  end

  alias ExAws.Dynamo

  def call(table_name, column_name, value, asc) do
    result = Dynamo.query(table_name,
      limit: 1,
      expression_attribute_values: [value: value],
      key_condition_expression: "#{column_name} = :value",
      scan_index_forward: asc
    )
    |> ExAws.request!

    user_web_session = case result do
      %{"Items" => items = [_|_]} -> {:ok, hd(items) |> ExAws.Dynamo.decode_item(as: UserWebSession)}
      _ -> {:error, "Empty struct"}
    end

    user_web_session
  end
end
