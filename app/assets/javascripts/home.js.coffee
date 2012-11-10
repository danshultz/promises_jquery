# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  # call chain, reads synchronous
  getAllPeople() # make ajax to get people
    .then(getAllPets) # get all pets for each person
    .then(buildElements) # build the UI Elements
    .then(appendToContainer) # show the ui to the container


getPeople = ->
  return $.ajax
    url: "/people",
    type: "GET",
    dataType: 'json',
    contentType: 'application/json'

getPets = (person_id) ->
  return $.ajax
    url: "/people/#{person_id}/pets",
    type: "GET",
    dataType: 'json',
    contentType: 'application/json'

getAllPeople = ->
  return getPeople()

getAllPets = (people) ->
  mapPeopleToPets = (pets...) ->
    people[i].pets = pet[0] for pet, i in pets 
    people

  $.when.apply($, getPets(person.id) for person in people)
    .pipe(mapPeopleToPets)

buildElements = (people) ->
  buildElement(person) for person in people

buildElement = (person) ->
  """
  <div>
    #{person.first_name} #{person.last_name}
    <ul>
      #{ ("<li>#{pet.name} - #{pet.kind}</li>" for pet in person.pets).join('') }
    </ul>
  </div>
  """

appendToContainer = (els) ->
  $(".people-list").append(els)

