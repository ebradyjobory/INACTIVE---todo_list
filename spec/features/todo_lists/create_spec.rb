require 'spec_helper'

describe "Creating todo list" do

	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "My todo list today"
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
		
	end
	it "redirects to the todo list index page on sucess" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "display an error when the todo list has no title" do
	  expect(TodoList.count).to eq(0)

	   create_todo_list title: ""
		expect(page). to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page). to_not have_content("This is what  I'm doing")  

	end

	it "display an error when the todo list has a title less than 3 charactors" do
	  expect(TodoList.count).to eq(0)

	    create_todo_list title: "Hi"

		expect(page). to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page). to_not have_content("This is what  I'm doing")  

	end

		it "display an error when the todo list has no description" do
	  expect(TodoList.count).to eq(0)

	    create_todo_list description: ""

		expect(page). to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page). to_not have_content("Grocery list")  

	end

	it "display an error when the todo list has no description less than 5" do
	  expect(TodoList.count).to eq(0)

	  create_todo_list description: "tom"

		expect(page). to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page). to_not have_content("Grocery list")  

	end


end