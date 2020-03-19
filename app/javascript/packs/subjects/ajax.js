$(document).on('turbolinks:load', function() {
  var target_path = /^(\/categories\/)[a-z]+$/gi;
  if (location.pathname === location.pathname.match(target_path)[0]) {
    reloadSubjectsTable();

    $("#new_subject_form").on("ajax:success", function(event) {
      $(this).find('input').val('');
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
