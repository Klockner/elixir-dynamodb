defmodule MetricsDynamoDBTest do
  use ExUnit.Case
  doctest MetricsDynamoDB

  test "greets the world" do
    assert MetricsDynamoDB.hello() == :world
  end

  test "create table" do
    IO.inspect(Mix.env)
    la = 'lala'
    a = MetricsDynamoDB.CreateEntry.call
  end
end
