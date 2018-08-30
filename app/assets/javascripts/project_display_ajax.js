$('#entry_button').on('click', function(e) {
    var project_val= $('#hour_project_id').val()
    var category = $('#hour_category_id').val()
    var hour_val = $('#hour_value').val()
    var hour_date = $('#hour_date').val()
    var hour_description = $('#hour_description').val()
    var user = $('#hour_user_id').val()
    if (project_val.length == 0 || category.length == 0 || hour_val.length == 0 || hour_date.length == 0 || hour_description.length == 0){
        $('#errors').text("hello")
    } else {
        $('#errors').text("")
    }
    var entry_data = {
        'user_id': user,
        'project_id': project_val,
        'category_id': category,
        'value': hour_val,
        'date': hour_date,
        'description': hour_description
    }


    $.ajax({
        url: '/hours',
        data: entry_data,
        type: 'POST',
        contentType: 'application/json',
        dataType: 'json',
        success: function(data) {
        $('#errors').text("hello");
     },
     error: function() {
        $('#errors').text("error")
     }

    })



    console.log()






    // var $select = $(this)
    // var project_id = $select.val()
    // if (!project_id) { return }
    // $.ajax({
    //     url: '/path/to/action/' + project_id
    // })
})
