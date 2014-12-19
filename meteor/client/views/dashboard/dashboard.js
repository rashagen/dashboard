Template.dashboard.rendered = function(){


/**

//Pie chart for wallet overview 
    function walletData() {
        var result = [];
        BitcoinWallets.find({}).forEach(function(wallet){
            result.push({"label": wallet.label, "value": wallet.balance()});
        });
        return result;
    };


// Wallet Pie chart
    nv.addGraph(function() {
        var areaWidth   = parseInt(d3.select("#pieChart svg").style("width").replace("px", ""),0);
        var centerWidth = -Math.floor(areaWidth/2);

        var chart = nv.models.pieChart()
                .x(function(d) { return d.label })
                .y(function(d) { return d.value })
                .showLabels(true)
                .labelThreshold(.05)  //Configure the minimum slice size for labels to show up
                .labelType("key") //Configure what type of data to show in the label. Can be "key", "value" or "percent"
                .color(['#9A2158', '#67163B', '#5A1333', '#A7245F', '#4E0928'])
        // Brand primary shades ['#9A2158', '#67163B', '#5A1333', '#A7245F', '#4E0928']
        // Brand secondary shades ['#0C5967', '#0D6574', '#159CB4', '#1CD3F3', '#09434E']
        // Brand .negative shades ['#FE2C2A', '#B11F1D', '#FE4543', '#981B19', '#711413']
            ;

        d3.select("#pieChart svg")
            .datum(walletData())
            .transition().duration(450)
            .call(chart)
        ;

        //    d3.select("#pieChart .nv-legendWrap")
        // .attr("transform", function () { return "translate(" + centerWidth + ",10)" ;
        // });
        //

        nv.utils.windowResize(chart.update);

        return chart;
    });

    // Line chart graph

    nv.addGraph(function() {
        var networthData = Meteor.user().networthData();
        var chart = nv.models.linePlusBarChart()
            .x(function(d) { return d[0] })
            .y(function(d) { return d[1] })
            .margin({top: 30, right: 100, bottom: 50, left: 70});

        chart.xAxis.tickFormat(function(d){ return d3.time.format('%W-%y')(new Date(d)) });

        chart.y1Axis.tickFormat(function(d) {return d3.format(',.4f')(d);});
        chart.y2Axis.tickFormat(function(d) { return d3.format(',.4f')(d);});

        var min = 0;
        var max = 0;
        networthData[0].values.forEach(function(valuepair) {
            min = Math.min(min, valuepair[1]);
            max = Math.max(max, valuepair[1]);
        });
        networthData[1].values.forEach(function(valuepair) {
            min = Math.min(min, valuepair[1]);
            max = Math.max(max, valuepair[1]);
        });
        chart.bars.forceY([min, max]);
        chart.lines.forceY([min, max]);

        d3.select('#networthChart svg')
            .datum(networthData)
            .call(chart)
        ;

        nv.utils.windowResize(chart.update);

        return chart;
    });
*/
};

// End dahsboard.rendered

// on the client
Template.dashboard.helpers({
    trades: function(){
        return Trades.find({},{sort: ['date','asc']}).fetch();
    },
    showPieChart: function(){
        return (true);
        //TODO: @Levin Please make this now show when there is no data.
    },
    totalBalance: function (currency)  {
        //TODO: Remove this. It is redundant to the global helper
        var saneNumber = function(internalNumber, currency) {
            if (currency === 'BTC') {
                return (internalNumber / 100000000).toFixed(8);
            } else {
                return (internalNumber / 100000000).toFixed(2);
            }
        };
        return saneNumber(Meteor.user().totalBalance(currency), currency);
    },
});

Template.dashboard.events({
    'click .delete-trade': function(event, template) {
        return Trades.remove({
            _id: this._id
        });
    }
});

// myTemplate.js
Template.dashboard.fundsDistribution = function(currency) {
    if (currency == 'BTC') {
        var dataPairs = [];
        BitcoinWallets.find({}).forEach(function (wallet) {
            dataPairs.push([wallet.label, wallet.balance()]);
        });
        return {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: "Distribution of Bitcoin holdings"
            },
            tooltip: {
                pointFormat: '<b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        },
                        connectorColor: 'silver'
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'genre',
                data: dataPairs
            }]
        };
    } else return;
};
