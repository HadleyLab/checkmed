// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require material
// do not require turbolinks because of material js
// do not require_tree .

$(document).ready(function() {
  var flmd;
  if ((flmd = $("#flash-message-deliverer")).length) {
    var msg = flmd.data('error') || flmd.data('alert') || flmd.data('notice');
    var notification = document.querySelector('.mdl-js-snackbar');
    notification.MaterialSnackbar.showSnackbar(
      {
        message: msg
      }
    );
    // TODO can't take MaterialSnackbar
  }

  // Activate correct user profile tab on page opening
  if ($("#user-profile-tabs").length && window.location.hash) {
    var tabsBlock = $("#user-profile-tabs");
    tabsBlock.find('.mdl-tabs__panel').each(function(indx) {
      var tabPanel = $(this);
      if (! tabPanel.hasClass('is-active')) {
        if ('#' + tabPanel.attr('id') == window.location.hash) {
          tabsBlock.find('.mdl-tabs__panel.is-active').removeClass('is-active');
          tabPanel.addClass('is-active');
          tabsBlock.find('.mdl-tabs__tab.is-active').removeClass('is-active');
          tabsBlock.find(".mdl-tabs__tab[href='#" + tabPanel.attr('id') + "']").addClass('is-active');
        }
      }
    });
  }

  // // Add nested fields to the form
  // $(".chlk-add-nested-fields-btn").click(function(evnt) {
  //   evnt.preventDefault();
  //   $link = $(this);
  //   var new_id = new Date().getTime();
  //   var regexp = new RegExp("new_" + $link.data('fields-association'), "g");
  //   $link.before($link.data('fields-template').replace(regexp, new_id));
  //   return false;
  // });
});

function add_nested_item_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
  componentHandler.upgradeAllRegistered();
}
