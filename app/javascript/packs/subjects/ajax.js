$(document).on('turbolinks:load', function() {
  var target_path = /^(\/categories\/)[a-z]+$/gi;
  var regex_path = location.pathname.match(target_path);

  if (regex_path && regex_path.includes(location.pathname)) {
    reloadSubjectsTable();

    $("#new_subject_form").on("ajax:success", function(event) {
      $(this).find('input, textarea').val('');
      reloadSubjectsTable();
    }).on("ajax:error", function(event) {
      var data, status, xhr;
      var list_items = $('#errors_modal_items').empty();
      [data, status, xhr] = event.detail;

      $.each(data.subject, function(index, value) {
        $('#errors_modal_items').append('<li>'+value+'</li>');
      });

      $('#errors_modal').modal('show');
    });

    $(document).on("ajax:success", "#edit_subject_form", function(event) {
      $('#edit_modal').modal('hide');
      reloadSubjectsTable();
    }).on("ajax:error", function(event) {
      var data, status, xhr;
      var list_items = $('#update_errors').empty();
      [data, status, xhr] = event.detail;

      $('#update_errors').append('<ul id="update_error_items"></ul>');
      $.each(data.errors, function(index, value) {
        $('#update_error_items').append('<li class="text-danger">'+value+'</li>');
      });
    });

    $(document).on("click", ".subject_edit_btn", function() {
      var code = location.pathname.split('/')[2];
      var id = $(this).data('subject-id');

      $.ajax('/categories/'+code+'/subjects/'+id+'/edit', { type: 'get' })
      .done(function(data) {
        var modal = $('#edit_modal').empty();
        modal.append(data);
        modal.modal('show');
      })
      .fail(function() {
        window.alert('科目の読み込みに失敗しました。');
      });
    });

    function reloadSubjectsTable() {
      var code = location.pathname.split('/')[2];
      $.ajax('/categories/'+code+'/subjects', { type: 'get' })
      .done(function(data) {
        var table = $('#subjects_table').empty();
        table.append(data);
      })
      .fail(function() {
        window.alert('科目の読み込みに失敗しました。');
      });
    }
  }
});
