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

class StandardTableBuilderTest < ActionView::TestCase
  
  # set dummy helper class for ActionView::TestCase
  self.helper_class = StandardHelper
  
  attr_reader :table
  
  def setup
    @table = StandardTableBuilder.new(["foo", "bahr"], self)
  end
  
  def format_size(obj)
    "#{obj.size} chars"
  end
  
  test "html header" do
    table.attrs :upcase, :size
    
    dom = '<tr><th>Upcase</th><th>Size</th></tr>'
    
    assert_dom_equal dom, table.send(:html_header)
  end

  test "single attr row" do
    table.attrs :upcase, :size
    
    dom = '<tr class="even"><td>FOO</td><td>3 chars</td></tr>'
    
    assert_dom_equal dom, table.send(:html_row, "foo")
  end
  
  test "custom row" do
    table.col("Header", :class => 'hula') {|e| "Weights #{e.size} kg" }
        
    dom = '<tr class="even"><td class="hula">Weights 3 kg</td></tr>'
    
    assert_dom_equal dom, table.send(:html_row, "foo")
  end
  
  test "attr col output" do
    table.attrs :upcase
    col = table.cols.first
    
    assert_equal "<th>Upcase</th>", col.html_header
    assert_equal "FOO", col.content("foo")
    assert_equal "<td>FOO</td>", col.html_cell("foo")
  end
  
  test "attr col content with custom format_size method" do
    table.attrs :size
    col = table.cols.first
    
    assert_equal "4 chars", col.content("abcd")
  end
  
  test "two x two table" do
    dom = <<-FIN
      <table class="list">
      <tr><th>Upcase</th><th>Size</th></tr>
      <tr class="even"><td>FOO</td><td>3 chars</td></tr>
      <tr class="odd"><td>BAHR</td><td>4 chars</td></tr>
      </table>
    FIN
    dom.gsub!(/[\n\t]/, "").gsub!(/\s{2,}/, "")
    
    table.attrs :upcase, :size
    
    assert_dom_equal dom, table.to_html
  end
  
  test "table with before and after cells" do 
    dom = <<-FIN
      <table class="list">
      <tr><th>head</th><th>Upcase</th><th>Size</th><th></th></tr>
      <tr class="even">
        <td class='left'><a href='/'>foo</a></td>
        <td>FOO</td>
        <td>3 chars</td>
        <td>Never foo</td>
      </tr>
      <tr class="odd">
        <td class='left'><a href='/'>bahr</a></td>
        <td>BAHR</td>
        <td>4 chars</td>
        <td>Never bahr</td>
      </tr>
      </table>
    FIN
    dom.gsub!(/[\n\t]/, "").gsub!(/\s{2,}/, "")
    
    table.col('head', :class => 'left') { |e| link_to e, "/" }
    table.attrs :upcase, :size
    table.col { |e| "Never #{e}" }
    
    
    assert_dom_equal dom, table.to_html
  end
  
end
