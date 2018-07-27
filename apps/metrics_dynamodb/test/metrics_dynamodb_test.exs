defmodule MetricsDynamoDBTest do
  use ExUnit.Case
  doctest MetricsDynamoDB

  test "greets the world" do
    assert MetricsDynamoDB.hello() == :world
  end

  @tag :skip
  test "create table" do
    MetricsDynamoDB.CreateTable.call
  end

  test "put item" do
    MetricsDynamoDB.PutItem.call
  end

  test "get item" do
    MetricsDynamoDB.GetItem.call
  end
end
