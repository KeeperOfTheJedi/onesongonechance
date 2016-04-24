
$(document).on('page:change', function(event) {
  var Accordion = function(el, multiple) {
    this.el = el || {};
    this.multiple = multiple || false;
    var links = this.el.find('.link');
    links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
  }
  Accordion.prototype.dropdown = function(e) {
    var $el = e.data.el;
      $this = $(this),
      $next = $this.next();
    $next.slideToggle();
    $this.parent().toggleClass('open');
    if (!e.data.multiple) {
      $el.find('.submenu').not($next).slideUp().parent().removeClass('open');
    };
  } 
  var accordion = new Accordion($('#accordion'), false);
});

//<a href="<%= url_for(my_profile_choose_pic_path) %>" data-load-remote="<%= url_for(my_profile_choose_pic_path) %>" data-toggle="modal">
$(document).on('page:change', function(event) {
  $('[data-toggle="modal"]').click(function(e) {
    e.preventDefault();
    var $this = $(this);
    // console.log($this)
    var remote = $this.data('load-remote');
    if (remote) {
      // console.log(remote)
      $.get(remote, function(data) {
        $('<div class="modal fade">' + data + '</div>').modal();
      });
    }
  });
});