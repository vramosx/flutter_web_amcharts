window.amchartsWrapperPlugin = class {
    chartObject = null;

    checkContext = async (element, selector) => {
        while (element.querySelector(selector) === null) {
            await new Promise(resolve => setTimeout(resolve, 500));
        }
        
        return element.querySelector(selector);
    };

    showPieChart = (chartId, config) => {
        this.checkContext(document, "flt-platform-view").then(platformView => {
            this.checkContext(platformView.shadowRoot, "#" + chartId).then(chart => {
                config = JSON.parse(config);
                var chartCreator = new amchartsCreator();
                chartCreator.createPieChart(chart, config);
            });
        });
    }

    showLineChart = (chartId, config) => {
        this.checkContext(document, "flt-platform-view").then(platformView => {
            this.checkContext(platformView.shadowRoot, "#" + chartId).then(chart => {
                config = JSON.parse(config);
                var chartCreator = new amchartsCreator();
                chartCreator.createLineChart(chart, config);
            });
        });
    }
}

amchartsCreator = class {
    createPieChart = (chartElement, config) => {
        am4core.useTheme(am4themes_animated);
        // instantiate
        var chart;
        if(config.is3D) {
            chart = am4core.create(chartElement, am4charts.PieChart3D);
        } else {
            chart = am4core.create(chartElement, am4charts.PieChart);
        }

        // configure pieSeries
        var pieSeries;
        if(config.is3D) {
            pieSeries = chart.series.push(new am4charts.PieSeries3D());
        } else {
            pieSeries = chart.series.push(new am4charts.PieSeries());
        }

        // configure data
        if(!config.dataSource) {
            chart.data = config.data;
            pieSeries.dataFields.value = "value";
            pieSeries.dataFields.category = "category";

            if(config.data[0].color) {
                // convert colors to amChart colors
                for (let i = 0; i < config.data.length; i++) {
                    if(!config.data[i].color) {
                        showError('You need to specify color for every item in config > data. Problem on item index: ' + i);
                        return;
                    }

                    config.data[i].color = am4core.color(config.data[i].color);
                }

                // set color as propertyFields
                pieSeries.slices.template.propertyFields.fill = 'color';
            }

        } else {
            chart.dataSource.url = config.dataSource
        }

        // pie chart innerRadius
        if(config.innerRadius) {
            chart.innerRadius = am4core.percent(config.innerRadius);
        }

        if(config.pieSeries) {
            // configure slices
            if(config.pieSeries.slices) {
                if(config.pieSeries.slices.template) {
                    if(config.pieSeries.slices.template.fillOpacity) {
                        pieSeries.slices.template.fillOpacity = config.pieSeries.slices.template.fillOpacity;
                    }

                    if(config.pieSeries.slices.template.stroke) {
                        pieSeries.slices.template.stroke = am4core.color(config.pieSeries.slices.template.stroke);
                    }

                    if(config.pieSeries.slices.template.strokeWidth) {
                        pieSeries.slices.template.strokeWidth = config.pieSeries.slices.template.strokeWidth;
                    }

                    if(config.pieSeries.slices.template.strokeOpacity) {
                        pieSeries.slices.template.strokeOpacity = config.pieSeries.slices.template.strokeOpacity;
                    }

                    if(config.pieSeries.slices.template.tooltipText) {
                        pieSeries.slices.template.tooltipText = config.pieSeries.slices.template.tooltipText;
                    }
                }
            }

            // configure labels
            if(config.pieSeries.labels) {
                // configure labels template
                if(config.pieSeries.labels.template) {
                    if(config.pieSeries.labels.template.disabled != null) {
                        pieSeries.labels.template.disabled = config.pieSeries.labels.template.disabled;
                    }

                    if(config.pieSeries.labels.template.text != null) {
                        pieSeries.labels.template.text = config.pieSeries.labels.template.text;
                    }
                }
            }

            if(config.pieSeries.ticks) {
                // configure ticks template
                if(config.pieSeries.ticks.template) {
                    if(config.pieSeries.ticks.template.disabled != null) {
                        pieSeries.ticks.template.disabled = config.pieSeries.ticks.template.disabled;
                    }
                }
            }
        }

        // configure default settings (no hover or active)
        if(config.defaultSettings) {
            var dfs = pieSeries.slices.template.states.getKey("default");

            if(config.defaultSettings.scale) {
                dfs.properties.scale = config.defaultSettings.scale;
            }

            if(config.defaultSettings.shiftRadius) {
                dfs.properties.shiftRadius = config.defaultSettings.shiftRadius;
            }

            if(config.defaultSettings.fillOpacity) {
                dfs.properties.fillOpacity = config.defaultSettings.fillOpacity;
            }
        }

        // configure onHover settings
        if(config.onHoverSettings) {
            var ohs = pieSeries.slices.template.states.getKey("hover");

            if(config.onHoverSettings.scale) {
                ohs.properties.scale = config.onHoverSettings.scale;
            }

            if(config.onHoverSettings.shiftRadius) {
                ohs.properties.shiftRadius = config.onHoverSettings.shiftRadius;
            }

            if(config.onHoverSettings.fillOpacity) {
                ohs.properties.fillOpacity = config.onHoverSettings.fillOpacity;
            }
        }

        // configure active settings
        if(config.onActiveSettings) {
            var oas = pieSeries.slices.template.states.getKey("active");

            if(config.onActiveSettings.scale) {
                oas.properties.scale = config.onActiveSettings.scale;
            }

            if(config.onActiveSettings.shiftRadius) {
                oas.properties.shiftRadius = config.onActiveSettings.shiftRadius;
            }

            if(config.onActiveSettings.fillOpacity) {
                oas.properties.fillOpacity = config.onActiveSettings.fillOpacity;
            }
        }

        // configure legend
        if(config.legend) {
            if(config.legend.active) {
                chart.legend = new am4charts.Legend();
            }

            if(config.legend.valueLabels) {
                if(config.legend.valueLabels.template) {
                    if(config.legend.valueLabels.template.text) {
                        chart.legend.valueLabels.template.text = config.legend.valueLabels.template.text;
                    }
                }
            }
        }

    }

    /*
    {
        "config":
        {
            "isDark": false,
            "useCursor": true,
            "zoomOutButton": false,
            "data": [
                {
                    "category": "2019-09-20",
                    "value": 0.56
                },
                {
                    "category": "2019-09-21",
                    "value": 0.65
                },
                {
                    "category": "2019-09-21",
                    "value": 0.98
                }
            ],
            "xAxes": {
                "type": "category",
                "dataFields": {
                    "category": "category"," 
                }
                "title": {
                    "text": "Countries"
                }
            },
            "yAxes": {
                "title": {
                    "text": "Values"
                }
            },
            "series": [{
                "id": "serie_unique_id",
                "name": "Name Series",
                "type": "line",
                "stroke": "hex color",
                "fill": "hex color or gradient",
                "strokeWidth": 3,
                "dataFields": {
                    "valueY": "value",
                    "categoryX": "category"
                }
            }],
            "legend": {
                "active": true,
                "position": "right",
                "scrollable": true,
                "highlightOnHover": true
            },
            "scrollbarX": {
                "enabled": true,
                "seriesId": "serie_unique_id"
            },
            "scrollbarY": {
                "enabled": true,
                "seriesId": "serie_unique_id"
            }
        }
    }
    */
    createLineChart = (chartElement, config) => {
        var chartSeries = {};
        am4core.useTheme(am4themes_animated);

        // instantiate
        var chart, yAxes, xAxes, series;
        chart = am4core.create(chartElement, am4charts.XYChart);

        if (config.isDark) {
            am4core.useTheme(am4themes_dark);
        }

        // configure dataSource
        if(!config.dataSource) {
            chart.data = config.data;
        } else {
            chart.dataSource.url = config.dataSource;
        }

        // Configure ZoomOutButton
        if(config.zoomOutButton == false) chart.zoomOutButton.disabled = true;

        // Configure xAxes
        if(config.xAxes) {
            switch(config.xAxes.type) {
                case 'category': 
                    xAxes = chart.xAxes.push(new am4charts.CategoryAxis()); 
                    xAxes.dataFields.category = "category";
                    break;
                case 'date': xAxes = chart.xAxes.push(new am4charts.DateAxis()); break;
            }
        }

        // Configure yAxes
        if(config.yAxes) {
            yAxes = chart.yAxes.push(new am4charts.ValueAxis());
            // configure yAxes title
            if(config.yAxes.title) {
                if(config.yAxes.title.text) {
                    yAxes.title.text = config.yAxes.title.text;
                }
            }
        }

        // configure legend
        if(config.legend) {
            if(config.legend.active) {
                chart.legend = new am4charts.Legend();
            }

            if(config.legend.position) {
                chart.legend.position = config.legend.position;
            }

            if(config.legend.scrollable) {
                chart.legend.scrollable = config.legend.scrollable;
            }

            if(config.legend.highlightOnHover) {
                chart.legend.itemContainers.template.events.on("over", function(event) {
                    onLegendHover_select(chart, event.target.dataItem.dataContext);
                });

                chart.legend.itemContainers.template.events.on("out", function(event) {
                    onLegendOut_deselect(chart, event.target.dataItem.dataContext);
                });
            }
        }


        // configure series
        if(config.series) {
            for (const serie in config.series) {
                const s = config.series[serie];
                var nserie = chart.series.push(new am4charts.LineSeries());

                if(s.dataFields) {
                    if(s.dataFields.valueY) {
                        nserie.dataFields.valueY = s.dataFields.valueY;
                    }

                    if(s.dataFields.categoryX) {
                        nserie.dataFields.categoryX = s.dataFields.categoryX;
                    }
                }
                
                if(s.name) nserie.name = s.name;
                if(s.stroke) nserie.stroke = am4core.color(s.stroke);
                if(s.strokeWidth) nserie.strokeWidth = s.strokeWidth;

                nserie.tooltipText = "{" + s.dataFields.valueY + "}";

                nserie.tooltip.background.cornerRadius = 20;
                nserie.tooltip.background.strokeOpacity = 0;
                nserie.tooltip.pointerOrientation = "vertical";
                nserie.tooltip.label.minWidth = 40;
                nserie.tooltip.label.minHeight = 40;
                nserie.tooltip.label.textAlign = "middle";
                nserie.tooltip.label.textValign = "middle";

                var bullet = nserie.bullets.push(new am4charts.CircleBullet());
                bullet.circle.strokeWidth = 2;
                bullet.circle.radius = 4;
                bullet.tooltipText = "[bold]CDI:[/] {cdi}%\n[bold]IBOV:[/] {ibov}%\n[bold]Poupança:[/] {poup}%";
                bullet.circle.fill = am4core.color("#fff");

                var bullethover = bullet.states.create("hover");
                bullethover.properties.scale = 1.3;

                if(s.fill) {
                    nserie.fillOpacity = 1;
                    nserie.fill = this.createColorGradient(s.fill);
                }

                chartSeries[s.id] = nserie;
            }
        }

        if(config.useCursor) {
            chart.cursor = new am4charts.XYCursor();
        }

        if(config.scrollbarX) {
            if(config.scrollbarX.enabled && config.scrollbarX.seriesId) {
                var scrollX = new am4charts.XYChartScrollbar();
                scrollX.series.push(chartSeries[config.scrollbarX.seriesId]);
                chart.scrollbarX = scrollX;
            }
            else if (config.scrollbarX.enabled && config.scrollbarX.seriesId){
                chart.scrollbarX = new am4core.Scrollbar();
            }
        }

        if(config.scrollbarY) {
            if(config.scrollbarY.enabled && config.scrollbarY.seriesId) {
                var scrollY = new am4core.XYChartScrollbar();
                scrollY.series.push(chartSeries[config.scrollbarY.seriesId]);
                chart.scrollbarY = scrollY;
            }
            else if (config.scrollbarY.enabled && config.scrollbarY.seriesId){
                chart.scrollbarY = new am4core.Scrollbar();
            }
        }
    }

    createColorGradient = (gradientJson) => {
        if (gradientJson.isGradient) {
          var gradient = new am4core.LinearGradient();
          gradient.rotation = 90;

          for (let i = 0; i < gradientJson.gradient.length; i++) {
            const g = gradientJson.gradient[i];
            gradient.addColor(am4core.color(g.color));
          }
          
          return gradient;
        }

        return am4core.color(gradientJson);
    }

    rgb2hex(rgb){
        rgb = rgb.match(/(.*?)(rgb|rgba)\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)/i);
        var rgbColor = (rgb && rgb.length >= 5) ? "#" +
         ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) +
         ("0" + parseInt(rgb[4],10).toString(16)).slice(-2) +
         ("0" + parseInt(rgb[5],10).toString(16)).slice(-2) : '';
        
         var alpha = rgb[6];
           return {
           "hex": rgbColor,
           "alpha": alpha
         }
    }
}

function onLegendHover_select(chart, hoveredSeries) {
    hoveredSeries.toFront();
    
    hoveredSeries.segments.each(function(segment) {
        segment.setState("hover");
    })
    
    chart.series.each(function(series) {
        if (series != hoveredSeries) {
        series.segments.each(function(segment) {
            segment.setState("dimmed");
        })
        series.bulletsContainer.setState("dimmed");
        }
    });
}

function onLegendOut_deselect(chart, hoveredSeries) {
    chart.series.each(function(series) {
        series.segments.each(function(segment) {
          segment.setState("default");
        })
        series.bulletsContainer.setState("default");
    });
}

function showError(msg) {
    console.error('[flutter_web_amcharts] ' + msg);
}