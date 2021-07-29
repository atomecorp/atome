class PaymentHelper {

    constructor(div_id, link) {
        $.cachedScript = function( url, options ) {
            // Allow user to set any option except for dataType, cache, and url
            options = $.extend( options || {}, {
                dataType: "script",
                cache: true,
                url: url
            });
            // Use $.ajax() since it is more flexible than $.getScript
            // Return the jqXHR object so we can chain callbacks
            return $.ajax( options );
        };

        $.cachedScript(link ).done(function( script, textStatus ) {
            function initPayPalButton() {
                paypal.Buttons({
                    style: {
                        shape: 'rect',
                        color: 'silver',
                        layout: 'vertical',
                        label: 'paypal',

                    },
                    createOrder: function(data, actions) {
                        return actions.order.create({
                            purchase_units: [{"amount":{"currency_code":"EUR","value":12,"breakdown":{"item_total":{"currency_code":"EUR","value":10},"shipping":{"currency_code":"EUR","value":0},"tax_total":{"currency_code":"EUR","value":2}}}}]
                        });
                    },

                    onApprove: function(data, actions) {
                        return actions.order.capture().then(function(details) {
                            alert('Transaction completed by ' + details.payer.name.given_name + '!');
                        });
                    },

                    onError: function(err) {
                        console.log(err);
                    }
                }).render('#'+div_id);
            }
            initPayPalButton();
        });
    }

}







