# frozen_string_literal: true


new({molecule: :chronology}) do |params|
  chr=box({width: '100%', height: 333, color: :white, smooth: 9})
  chr_id=chr.id
  JS.eval <<~JS
 // create a dataset with items
  // we specify the type of the fields `start` and `end` here to be strings
  // containing an ISO date. The fields will be outputted as ISO dates
  // automatically getting data from the DataSet via items.get().
  var items = new vis.DataSet({
    type: { start: 'ISODate', end: 'ISODate' }
  });

  // add items to the DataSet
  items.add([
    {id: 1, content: 'item 1<br>start', start: '2014-01-23'},
    {id: 2, content: 'item 2', start: '2014-01-18'},
    {id: 3, content: 'item 3', start: '2014-01-21'},
    {id: 4, content: 'item 4', start: '2014-01-19', end: '2014-01-24'},
    {id: 5, content: 'item 5', start: '2014-01-28', type:'point'},
    {id: 6, content: 'item 6', start: '2014-01-26'}
  ]);

  // log changes to the console
  items.on('*', function (event, properties) {
    console.log(event, properties.items);
  });

  var container = document.getElementById('#{chr_id}');

  var options = {
    start: '2014-01-10',
    end: '2014-02-10',
    height: '300px',

    // allow selecting multiple items using ctrl+click, shift+click, or hold.
    multiselect: true,

    // allow manipulation of items
    editable: true,

    /* alternatively, enable/disable individual actions:

    editable: {
      add: true,
      updateTime: true,
      updateGroup: true,
      remove: true
    },

    */

    showCurrentTime: true
  };

  var timeline = new vis.Timeline(container, items, options);


  
    JS

end




chronology({})
