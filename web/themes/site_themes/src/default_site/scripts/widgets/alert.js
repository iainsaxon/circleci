var $ = require('jquery');

require('jquery-ui/widget');

$.widget( "nsm.alert", {
    _create: function () {
        console.log('created');
    }
});

