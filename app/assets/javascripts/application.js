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
//= require Sortable
// do not require turbolinks because of material js
// do not require_tree .

$(document).ready(function() {
  // Flash messages thru mdl snackbar
  var flmd;
  if ((flmd = $("#flash-message-deliverer")).length) {
    var msg = flmd.data('msg-error') || flmd.data('msg-alert') || flmd.data('msg-notice');
    var marSb = new MaterialSnackbar(document.querySelector('.mdl-js-snackbar'));
    marSb.showSnackbar({ message: msg });
  }

  // Activate correct user profile tab with menu item click or hash in the url
  if ($("#user-profile-tabs").length) {
    var tabsBlock = $("#user-profile-tabs");

    function activateUserProfileTab(sHash) {
      tabsBlock.find('.mdl-tabs__panel').each(function(indx) {
        var tabPanel = $(this);
        if (! tabPanel.hasClass('is-active')) {
          if ('#' + tabPanel.attr('id') == sHash) {
            tabsBlock.find('.mdl-tabs__panel.is-active').removeClass('is-active');
            tabPanel.addClass('is-active');
            tabsBlock.find('.mdl-tabs__tab.is-active').removeClass('is-active');
            tabsBlock.find(".mdl-tabs__tab[href='#" + tabPanel.attr('id') + "']").addClass('is-active');
            return false;
          }
        }
      });
    }

    $(".special-menu-link-of-subpart-of-page").click(function(evnt) {
      evnt.preventDefault();
      var linkhref = $(this).attr('href');
      var hashPart = linkhref.substr(linkhref.search(/\#/));
      activateUserProfileTab(hashPart);
      // Hack to close the Drawer
      if ($(".mdl-layout__drawer").hasClass('is-visible')) {
        $(".mdl-layout__drawer").removeClass('is-visible').attr('aria-hidden', 'true');
        $(".mdl-layout__obfuscator").removeClass('is-visible');
        $(".mdl-layout__drawer-button").attr('aria-expanded', 'false');
      }
      return false;
    });

    if (window.location.hash) activateUserProfileTab(window.location.hash);
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

  $(".chkl-form-groups").each(function(indx) {
    var groupsSortable = new Sortable(this, {
      handle: ".group-ordering-handler",
      onUpdate: function(evnt) {
        $(evnt.item).closest(".chkl-form-groups").
                     find(".chkl-form-group > input.ordering-prior-input").
                     each(function(indx) {
          $(this).val(indx);
        });
        var item
      }
    });
  });

  $(".chkl-form-group-questions").each(function(indx) {
    var questionsSortable = new Sortable(this, {
      handle: ".question-ordering-handler",
      onUpdate: function(evnt) {
        $(evnt.item).closest(".chkl-form-group-questions").
                     find(".chkl-form-question > input.ordering-prior-input").
                     each(function(indx) {
          $(this).val(indx);
        });
        var item
      }
    });
  });

  $(".chkl-form-question-answers").each(function(indx) {
    var answersSortable = new Sortable(this, {
      handle: ".answer-ordering-handler",
      onUpdate: function(evnt) {
        $(evnt.item).closest(".chkl-form-question-answers").
                     find(".chkl-form-answer > input.ordering-prior-input").
                     each(function(indx) {
          $(this).val(indx);
        });
        var item
      }
    });
  });
});

function add_nested_item_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
  componentHandler.upgradeAllRegistered();
}
