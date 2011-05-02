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

class DiskTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "label" do
    disk = disks(:one)
    assert_equal disk.model, disk.label
  end
  test "age in days" do
    disk = disks(:one)
    disk.purchase_date = Date.today - 1.week
    assert_equal(7, disk.age_in_days)
  end
  test "versioned" do
    disk = Disk.new
    disk.save
    assert_equal(1, disk.version, "version 1")
    disk.notes = "Check"
    assert disk.save
    assert_equal(2, disk.version, "version 2")
    puts disk.versions.count
  end
  test "warranty till days" do
    disk = disks(:one)
    disk.warranty_till = Date.today + 1.week
    assert_equal(7, disk.warranty_end_in_days)
  end
end
