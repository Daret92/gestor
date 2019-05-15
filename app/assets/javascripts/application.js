// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require bootstrap-select
//= require activestorage
//= require turbolinks
//= require datatables
//= require_tree .
//= require serviceworker-companion

$( document ).on('turbolinks:load', function() {
  
    $('.navbar a[href^="#"]').click(function() {
      var destino = $(this.hash);
      if (destino.length == 0) {
        destino = $('a[name="' + this.hash.substr(1) + '"]');
      }
      if (destino.length == 0) {
        destino = $('html');
      }
      $('html, body').animate({ scrollTop: destino.offset().top - 200 }, 200);
      return false;
  }); 
  $('.scrolls a[href^="#"]').click(function() {
      var destino = $(this.hash);
      if (destino.length == 0) {
        destino = $('a[name="' + this.hash.substr(1) + '"]');
      }
      if (destino.length == 0) {
        destino = $('html');
      }
      $('html, body').animate({ scrollTop: destino.offset().top - 200 }, 200);
      return false;

  }); 

  $('.radios').on('click',function(){
    var id = $(this).data('id')
    $.ajax({
      method: "GET",
      url: '/update_materials',
      data: { ids: id},
      success: function(data){
      }
      });
  });
  $('.radiosv').on('click',function(){
    var id = $(this).data('id')
    $.ajax({
      method: "GET",
      url: '/validate_materials',
      data: { ids: id},
      success: function(data){
      }
      });
  });
  

  $('.radioViaticos').on('click',function(){
    var id = $(this).data('id')
    $.ajax({
      method: "GET",
      url: '/update_viaticos',
      data: { ids: id},
      success: function(data){
      }
      });
  });

  $('.auth_solicitud').on('click',function(){
    var id = $(this).data('solicitud')
    $.ajax({
      method: "GET",
      url: '/authSolicitud',
      data: { ids: id},
      success: function(data){
        location.reload();
      }
      });
  });

  $('.auth_cancel').on('click',function(){
    var id = $(this).data('solicitud')
    $.ajax({
      method: "GET",
      url: '/cancSolicitud',
      data: { ids: id},
      success: function(data){
        location.reload(); 
      }
      });
  });
$('.fin_solicitud').on('click',function(){
    var id = $(this).data('solicitud')
    $.ajax({
      method: "GET",
      url: '/finSolicitud',
      data: { ids: id},
      success: function(data){
        location.reload();
      }
      });
  });


  $('form').on('click', '.remove_record',function(event){
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });
  $('form').on('click', '.add_fields',function(event){
    var ultimo = $('.fields').find('tr').find('.selecciones option:selected');
    
    if(ultimo.val() != 'Seleccionar pagina'){
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'),'g');
    var algo = $('.fields').find('tr').find('.selecciones option:selected');
    algo_ar = []
    $.each(algo, function(a,e){
      algo_ar.push(e.text);
    });

    $('.fields').append($(this).data('fields').replace(regexp,time));
    $.each(algo_ar,function(e,a){
      if(a !='Seleccionar pagina'){
        $('.fields').find('tr').last().find('.selecciones option[value=' + a + ']').hide();    
      }      
    });
      
    //$(this).find("").hide();

      return event.preventDefault();
    }else{
      alert('Ingresa una pagina valida')
    }
  }) ;



  $('form').on('click', '.add_users',function(event){
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'),'g');
    $('.fields_users').append($(this).data('field').replace(regexp,time));
    return event.preventDefault();
  }) ;

  $('form').on('click', '.add_vehiculo',function(event){
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'),'g');
    $('.fields_vehiculo').append($(this).data('fieldv').replace(regexp,time));
    return event.preventDefault();
  });

  $('form').on('click', '.add_viatico',function(event){
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'),'g');
    $('.fields_viatico').append($(this).data('fieldvi').replace(regexp,time));
    return event.preventDefault();
  }) ;
  
$('form').on('click', '.add_otro',function(event){
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'),'g');
    $('.fields_otro').append($(this).data('fieldo').replace(regexp,time));
    return event.preventDefault();
  }) ;




  "use strict"; // Start of use strict
  
  $('.dataTable').DataTable();
  // Toggle the side navigation
  $("#sidebarToggle, #sidebarToggleTop").on('click', function(e) {
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
    if ($(".sidebar").hasClass("toggled")) {
      $('.sidebar .collapse').collapse('hide');
    };
  });

  // Close any open menu accordions when window is resized below 768px
  $(window).resize(function() {
    if ($(window).width() < 768) {
      $('.sidebar .collapse').collapse('hide');
    };
  });

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(e) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    e.preventDefault();
  });

}); // End of use strict
