$(function() {
  $("form").on("ajax:success", function(event) {
    var data, status, xhr;
    [data, status, xhr] = event.detail;
  }).on("ajax:error", function(event) {
    var data, status, xhr;
    var list_items = $('#errors_modal_items').empty();
    [data, status, xhr] = event.detail;

    $.each(data.subject, function(index, value) {
      $('#errors_modal_items').append('<li>'+value+'</li>');
    });

    $('#errors_modal').modal('show');
  });

  // function reloadSubjectsTable() {
  //   $.ajax('get.php', { type: 'get' })
  //     .done(function(data) {
  //       var table = $('#subjects_table').empty();
  //       table.append(data);
  //     })
  //     .fail(function() {
  //       window.alert('科目の読み込みに失敗しました。');
  //     });
  // }
});
