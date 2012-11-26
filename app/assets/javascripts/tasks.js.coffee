# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#datepicker').datepicker
    minDate: -0, 
    dateFormat: 'yy-mm-dd'

  $('#timepicker').timepicker

  $('input#task_tag').autocomplete
  	source: ["Home","Work","Travel","Personal", "Fun","Health","Other"]

