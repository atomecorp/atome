# frozen_string_literal: true

new({molecule: :chronology}) do |params|
  chr=box({width: '100%', height: 333, color: :white, smooth: 9})
  chr_id=chr.id
  JS.eval <<~JS
 // Create a dataset with items
        var items = new vis.DataSet({
            type: { start: 'ISODate', end: 'ISODate' }
        });

        // Add items to the DataSet
        items.add([
            {id: 1, content: 'item 1<br>start', start: '2014-01-23'},
            {id: 2, content: 'item 2', start: '2014-01-18'},
            {id: 3, content: 'item 3', start: '2014-01-21', end: '2014-01-24'},
            {id: 4, content: 'item 4', start: '2014-01-19', end: '2014-01-24'},
            {id: 5, content: 'item 5', start: '2014-01-28', type: 'point'},
            {id: 'kjhdkfjghdkjfgh', content: 'item 6', start: '2014-01-26'}
        ]);

        // Log changes to the console
        items.on('*', function (event, properties) {
            console.log(event, properties.items);
        });

    var container = document.getElementById('#{chr_id}');


    var options = {
    start: '2014-01-10',
    end: '2014-02-10',
    height: '300px',

    // Allow selecting multiple items using ctrl+click, shift+click, or hold.
    multiselect: true,

    // Allow manipulation of items
    editable: true,

    showCurrentTime: true,

    // Disable snapping to grid/markers
    snap: null
};

        var timeline = new vis.Timeline(container, items, options);

        setTimeout(() => {
            items.update({id: 1, content: 'Updated Event 1'});
            console.log('Event 1 content updated!');
        }, 2000);

        // Modify the content and add an `end` date when clicking on an event
        timeline.on('click', function (properties) {
            const itemId = properties.item;

            if (itemId) {
                const item = items.get(itemId);

                // Check if the item has an `end` date, if not, add one
                if (!item.end) {
                    // Set the `end` date to 2 days after the `start` date
                    let endDate = new Date(item.start);
                    endDate.setDate(endDate.getDate() + 2);

                    items.update({id: itemId, end: endDate.toISOString()});
                    console.log(`Event ${itemId} extended! New end date: ${endDate}`);
                }

                // Update the content of the item
                items.update({id: itemId, content: 'Updated Content'});
                console.log(`Event ${itemId} content updated!`);
            } else {
                console.log('Click outside of any event');
            }
        });
    JS

end




chronology({})

def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "DataSet",
    "Timeline",
    "add",
    "end",
    "eval",
    "get",
    "getDate",
    "getElementById",
    "id",
    "item",
    "items",
    "log",
    "on",
    "setDate",
    "start",
    "toISOString",
    "update"
  ],
  "DataSet": {
    "aim": "The `DataSet` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `DataSet`."
  },
  "Timeline": {
    "aim": "The `Timeline` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `Timeline`."
  },
  "add": {
    "aim": "The `add` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `add`."
  },
  "end": {
    "aim": "The `end` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `end`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "get": {
    "aim": "The `get` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `get`."
  },
  "getDate": {
    "aim": "The `getDate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getDate`."
  },
  "getElementById": {
    "aim": "The `getElementById` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getElementById`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "item": {
    "aim": "The `item` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `item`."
  },
  "items": {
    "aim": "The `items` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `items`."
  },
  "log": {
    "aim": "The `log` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `log`."
  },
  "on": {
    "aim": "The `on` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `on`."
  },
  "setDate": {
    "aim": "The `setDate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `setDate`."
  },
  "start": {
    "aim": "The `start` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `start`."
  },
  "toISOString": {
    "aim": "The `toISOString` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `toISOString`."
  },
  "update": {
    "aim": "The `update` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `update`."
  }
}
end
