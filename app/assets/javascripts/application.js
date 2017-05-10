// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tinymce/tinymce.min.js
//= require tinymce/jquery.tinymce.min.js
//= require_tree .

// 필요한 플러그인은 나중에 수정할것
tinymce.init({
    selector: '.tinymce',
    height: 300,
    theme: 'modern',
    menubar: false,
    default_link_target: "_blank",
    link_title: false,
    language : "ko_KR",
    plugins: [
        'advlist autolink lists link preview visualblocks',
        'contextmenu paste autosave emoticons preview'
    ],
    toolbar: 'newdocument undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist ' +
                '| link emoticons | preview'
});
