$('ul.project-list').html("<%= j render(partial: 'project_js' , locals: { projects: [@project] }) %>")
debugger
