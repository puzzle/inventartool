#  | # COPYRIGHT HEADER START # 
# |   InventarTool - Web Application to manage hardware and components inventory
# |   Copyright (C) 2011  Puzzle ITC GmbH www.puzzle.ch
# |   
# |   This program is free software: you can redistribute it and/or modify
# |   it under the terms of the GNU Affero General Public License as
# |   published by the Free Software Foundation, either version 3 of the
# |   License, or (at your option) any later version.
# |   
# |   This program is distributed in the hope that it will be useful,
# |   but WITHOUT ANY WARRANTY; without even the implied warranty of
# |   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# |   GNU Affero General Public License for more details.
# |   
# |   You should have received a copy of the GNU Affero General Public License
# |   along with this program.  If not, see <http://www.gnu.org/licenses/>.
# | # COPYRIGHT HEADER END # 
 

require 'test_helper'
require 'crud_test_model'
require 'custom_assertions'

class ListHelperTest < ActionView::TestCase
  
  REGEXP_ROWS = /<tr.+?<\/tr>/m
  REGEXP_HEADERS = /<th.+?<\/th>/m
  REGEXP_SORT_HEADERS = /<th><a .*?sort_dir=asc.*?>.*?<\/a><\/th>/m
  
  include StandardHelper
  include CrudTestHelper
  include CustomAssertions
  
  setup :reset_db, :setup_db, :create_test_data
  teardown :reset_db
  
  test "standard list table" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do 
      list_table
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 11, REGEXP_SORT_HEADERS, t
  end
  
  test "custom list table with attributes" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do
      list_table :name, :children, :companion_id
    end
        
    assert_count 7, REGEXP_ROWS, t
    assert_count 3, REGEXP_SORT_HEADERS, t
  end
    
  test "custom list table with block" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do
      list_table do |t|
        t.attrs :name, :children, :companion_id
        t.col("head") {|e| content_tag :span, e.income.to_s }
      end
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 4, REGEXP_HEADERS, t
    assert_count 0, REGEXP_SORT_HEADERS, t
    assert_count 6, /<span>.+?<\/span>/, t
  end
  
  test "custom list table with attributes and block" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do
      list_table :name, :children, :companion_id do |t|
        t.col("head") {|e| content_tag :span, e.income.to_s }
      end
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 3, REGEXP_SORT_HEADERS, t
    assert_count 4, REGEXP_HEADERS, t
    assert_count 6, /<span>.+?<\/span>/, t
  end
    
  test "standard list table with ascending sort params" do
    def params
      {:sort => 'children', :sort_dir => 'asc'}
    end
  
    @entries = CrudTestModel.all
    
    t = with_test_routing do 
      list_table
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 10, REGEXP_SORT_HEADERS, t
    assert_count 1, /<th><a .*?sort_dir=desc.*?>Children<\/a> &darr;<\/th>/, t
  end
  
  test "standard list table with descending sort params" do
    def params
      {:sort => 'children', :sort_dir => 'desc'}
    end
  
    @entries = CrudTestModel.all
    
    t = with_test_routing do 
      list_table
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 10, REGEXP_SORT_HEADERS, t
    assert_count 1, /<th><a .*?sort_dir=asc.*?>Children<\/a> &uarr;<\/th>/, t
  end
    
  test "list table with custom column sort params" do
    def params
      {:sort => 'chatty', :sort_dir => 'asc'}
    end
  
    @entries = CrudTestModel.all
    
    t = with_test_routing do 
      list_table :name, :children, :chatty
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 2, REGEXP_SORT_HEADERS, t
    assert_count 1, /<th><a .*?sort_dir=desc.*?>Chatty<\/a> &darr;<\/th>/, t
  end
  
  test "default attributes do not include id" do 
    assert_equal [:name, :whatever, :children, :companion_id, :rating, :income, 
                  :birthdate, :human, :remarks, :created_at, :updated_at], default_attrs
  end
  
  # Controller helper methods for the tests
  
  def model_class
    CrudTestModel
  end
  
  def params
  	{}
  end
  
  def sortable?(attr)
  	true
  end

    
end
