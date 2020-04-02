$(document).on('turbolinks:load', function() {
  var target_path = /^\/categories\/[a-z]+\/subjects\/[0-9a-z]+$/gi;
  var regex_path = location.pathname.match(target_path);

  if (regex_path && regex_path.includes(location.pathname)) {
    reloadTasksTable();

    $("#new_task_form").on("ajax:success", function(event) {
      $(this).find('input, textarea').val('');
      reloadTasksTable();
    }).on("ajax:error", function(event) {
      var data, status, xhr;
      var list_items = $('#errors_modal_items').empty();
      [data, status, xhr] = event.detail;

      $.each(data.subject, function(index, value) {
        $('#errors_modal_items').append('<li>'+value+'</li>');
      });

      $('#errors_modal').modal('show');
    });

    $(document).on("ajax:success", "#edit_task_form", function(event) {
      $('#edit_modal').modal('hide');
      reloadTasksTable();
    }).on("ajax:error", function(event) {
      var data, status, xhr;
      var list_items = $('#update_errors').empty();
      [data, status, xhr] = event.detail;

      $('#update_errors').append('<ul id="update_error_items"></ul>');
      $.each(data.errors, function(index, value) {
        $('#update_error_items').append('<li class="text-danger">'+value+'</li>');
      });
    });

    $(document).on("click", ".task_edit_btn", function() {
      var code = location.pathname.split('/')[2];
      var subject_id = location.pathname.split('/')[4];
      var id = $(this).data('task-id');

      $.ajax('/categories/'+code+'/subjects/'+subject_id+'/tasks/'+id+'/edit', { type: 'get' })
      .done(function(data) {
        var modal = $('#edit_modal').empty();
        modal.append(data);
        modal.modal('show');
      })
      .fail(function() {
        window.alert('タスクの読み込みに失敗しました。');
      });
    });

    function reloadTasksTable() {
      var code = location.pathname.split('/')[2];
      var id = location.pathname.split('/')[4];
      $.ajax('/categories/'+code+'/subjects/'+id+'/tasks', { type: 'get' })
      .done(function(data) {
        var table = $('#tasks_table').empty();
        table.append(data);
      })
      .fail(function() {
        window.alert('タスクの読み込みに失敗しました。');
      });
    }
  }
});
