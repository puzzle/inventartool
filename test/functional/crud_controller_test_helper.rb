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
 

# A module to include into your functional tests for your crud controller subclasses.
# Simply implement the two methods :test_entry and :test_entry_attrs to test the basic
# crud functionality. Override the test methods if you changed the behaviour in your subclass
# controller.
module CrudControllerTestHelper 
    
  def test_index
    get :index
    assert_response :success
    assert_template 'index'
    assert_present assigns(:entries)
  end
  
  def test_index_xml
    get :index, :format => 'xml'
    assert_response :success
    assert_present assigns(:entries)
    assert @response.body.starts_with?("<?xml")
  end
  
  def test_index_search
    field = @controller.search_columns.first
    val = field && test_entry[field].to_s
    return if val.blank?   # does not support search or no value in this field
 
    get :index, :q => val[0..((val.size + 1)/ 2)]
    assert_response :success
    assert_present assigns(:entries)
    assert assigns(:entries).include?(test_entry)
  end
  
  def test_index_sort_asc
    col = model_class.column_names.first
    get :index, :sort => col, :sort_dir => 'asc'
    assert_response :success
    assert_present assigns(:entries)
    sorted = assigns(:entries).sort_by &(col.to_sym)
    assert sorted, assigns(:entries)
  end
    
  def test_index_sort_desc
    col = model_class.column_names.first
    get :index, :sort => col, :sort_dir => 'desc'
    assert_response :success
    assert_present assigns(:entries)
    sorted = assigns(:entries).sort_by &(col.to_sym)
    assert sorted.reverse, assigns(:entries)
  end
  
  def test_show
    get :show, :id => test_entry.id
    assert_response :success
    assert_template 'show'
    assert_equal test_entry, assigns(:entry)
  end
  
  def test_show_xml
    get :show, :id => test_entry.id, :format => 'xml'
    assert_response :success
    assert_equal test_entry, assigns(:entry)
    assert @response.body.starts_with?("<?xml")
  end
  
  def test_show_with_not_existing_id_raises_RecordNotFound
    assert_raise(ActiveRecord::RecordNotFound) do
      get :show, :id => 9999
    end
  end
  
  def test_show_without_id_redirects_to_index
    assert_raise(ActionController::RoutingError) do
      get :show
    end
  end
  
  def test_new
    get :new
    assert_response :success
    assert_template 'new'
    assert assigns(:entry).new_record?
  end
  
  def test_create
    assert_difference("#{model_class.name}.count") do
      post :create, model_identifier => test_entry_attrs
    end
    assert_redirected_to assigns(:entry)
    assert ! assigns(:entry).new_record?
    assert_test_attrs_equal
  end
  
  def test_create_xml
    assert_difference("#{model_class.name}.count") do
      post :create, model_identifier => test_entry_attrs, :format => 'xml'
    end
    assert_response :success
    assert @response.body.starts_with?("<?xml")
  end
  
  def test_edit
    get :edit, :id => test_entry.id
    assert_response :success
    assert_template 'edit'
    assert_equal test_entry, assigns(:entry)
  end
  
  def test_edit_without_id_raises_RecordNotFound
    assert_raise(ActionController::RoutingError) do
      get :edit
    end
  end
  
  def test_update
    assert_no_difference("#{model_class.name}.count") do
      put :update, :id => test_entry.id, model_identifier => test_entry_attrs
    end
    assert_test_attrs_equal
    assert_redirected_to assigns(:entry)
  end

  def test_update_xml
    assert_no_difference("#{model_class.name}.count") do
      put :update, :id => test_entry.id, model_identifier => test_entry_attrs, :format => 'xml'
    end
    assert_response :success
    assert_equal "", @response.body.strip
  end

  def test_destroy
    assert_difference("#{model_class.name}.count", -1) do
      delete :destroy, :id => test_entry.id
    end
    assert_redirected_to_index
  end

  def test_destroy_xml
    assert_difference("#{model_class.name}.count", -1) do
      delete :destroy, :id => test_entry.id, :format => 'xml'
    end
    assert_response :success
    assert_equal "", @response.body.strip
  end
  
  # no need to test http methods for pure restfull controllers
  def ignore_test_create_with_wrong_http_method_redirects
    get :create, model_identifier => test_entry_attrs
    assert_redirected_to_index
    
    put :create, model_identifier => test_entry_attrs
    assert_redirected_to_index
    
    delete :create, model_identifier => test_entry_attrs
    assert_redirected_to_index
  end

  # no need to test http methods for pure restfull controllers
  def ignore_test_update_with_wrong_http_method_redirects
    get :update, :id => test_entry.id, model_identifier => test_entry_attrs
    assert_redirected_to_index
    
    delete :update, :id => test_entry.id, model_identifier => test_entry_attrs
    assert_redirected_to_index
  end
  
  # no need to test http methods for pure restfull controllers
  def ignore_test_destroy_with_wrong_http_method_redirects
    get :destroy, :id => test_entry.id
    assert_redirected_to_index
    
    put :destroy, :id => test_entry.id
    assert_redirected_to_index
  end

  protected 
  
  def assert_redirected_to_index
    assert_redirected_to :action => 'index', :returning => true
  end
  
  def assert_test_attrs_equal
    test_entry_attrs.each do |key, value|
      actual = assigns(:entry).send(key)
      assert_equal value, actual, "#{key} is expected to be <#{value.inspect}>, got <#{actual.inspect}>"
    end
  end
  
  def model_class
    @controller.model_class
  end
  
  def model_identifier
    @controller.model_identifier
  end
  
  # Test object used in several tests
  def test_entry
    raise "Implement this method in your test class"
  end
  
  # Attribute hash used in several tests
  def test_entry_attrs
    raise "Implement this method in your test class"
  end
  
end
