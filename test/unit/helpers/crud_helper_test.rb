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

class CrudHelperTest < ActionView::TestCase
  
  REGEXP_ROWS = /<tr.+?<\/tr>/m
  REGEXP_HEADERS = /<th.+?<\/th>/m
  REGEXP_SORT_HEADERS = /<th><a .*?sort_dir=asc.*?>.*?<\/a><\/th>/m
  REGEXP_ACTION_CELL = /<td class=\"center\"><a href.+?<\/a><\/td>/m
  
  include CustomAssertions
  include StandardHelper
  include ListHelper
  include CrudTestHelper
  
  setup :reset_db, :setup_db, :create_test_data
  teardown :reset_db
  
  test "standard crud table" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do 
      crud_table
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 11, REGEXP_SORT_HEADERS, t
    assert_count 18, REGEXP_ACTION_CELL, t      # show, edit, delete links
  end
  
  test "custom crud table with attributes" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do
      crud_table :name, :children, :companion_id
    end
        
    assert_count 7, REGEXP_ROWS, t
    assert_count 3, REGEXP_SORT_HEADERS, t
    assert_count 18, REGEXP_ACTION_CELL, t      # show, edit, delete links
  end
    
  test "custom crud table with block" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do
      crud_table do |t|
        t.attrs :name, :children, :companion_id
        t.col("head") {|e| content_tag :span, e.income.to_s }
      end
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 4, REGEXP_HEADERS, t
    assert_count 6, /<span>.+?<\/span>/m, t
    assert_count 0, REGEXP_ACTION_CELL, t      # no show, edit, delete links
  end
  
  test "custom crud table with attributes and block" do
    @entries = CrudTestModel.all
    
    t = with_test_routing do
      crud_table :name, :children, :companion_id do |t|
        t.col("head") {|e| content_tag :span, e.income.to_s }
      end
    end
    
    assert_count 7, REGEXP_ROWS, t
    assert_count 4, REGEXP_HEADERS, t
    assert_count 6, /<span>.+?<\/span>/m, t
    assert_count 0, REGEXP_ACTION_CELL, t      # no show, edit, delete links
  end
  
  
  test "crud form" do
    @entry = CrudTestModel.first
    f = with_test_routing do
      capture { crud_form }
    end
    
    assert_match /form .*?action="\/crud_test_models\/#{@entry.id}"/, f
    assert_match /input .*?name="crud_test_model\[name\]" .*?type="text"/, f
    assert_match /input .*?name="crud_test_model\[whatever\]" .*?type="text"/, f
    assert_match /input .*?name="crud_test_model\[children\]" .*?type="number"/, f
    assert_match /input .*?name="crud_test_model\[rating\]" .*?type="number"/, f
    assert_match /input .*?name="crud_test_model\[income\]" .*?type="number"/, f
    assert_match /select .*?name="crud_test_model\[birthdate\(1i\)\]"/, f
    assert_match /input .*?name="crud_test_model\[human\]" .*?type="checkbox"/, f
    assert_match /select .*?name="crud_test_model\[companion_id\]"/, f
    assert_match /textarea .*?name="crud_test_model\[remarks\]"/, f
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
