project_name="atome_test_project"
`cd /Users/jeezs/Desktop;rm -rf  #{project_name} `
`cd ..;gem build`
`cd ..;gem install atome`
`cd /Users/jeezs/Desktop;atome create #{project_name}`
`open /Users/jeezs/Desktop/#{project_name}/index.rb`
`open /Users/jeezs/Desktop/#{project_name}/build/index.html`