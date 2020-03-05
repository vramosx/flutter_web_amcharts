window.amchartsWrapperPlugin = class {
    chartObject = null;

    checkContext = async (element, selector) => {
        while (element.querySelector(selector) === null) {
            await new Promise(resolve => setTimeout(resolve, 500));
        }
        
        return element.querySelector(selector);
    };

    showChart = (chartId, config) => {
        config = JSON.parse(config);

        // id

    }
}

amchartsCreator = class {

    /*
    * PieChartConfig:
    *   - is3D: bool,
    *   - data: {
    *       color: string HEX color,
    *       category: string
    *       value: double
    *   }
    *   - dataSource: String<url>
    *   - innerRadius: int
    *   - pieSeries: {
    *       - labels {
    *           - template: {
    *               - disabled: bool
    *               - text: string
    *           }
    *       }
    *       - ticks: {
    *           - template: {
    *               - disabled: bool
    *           }
    *       }
    *       - dataFields: {
    *       }
    *       - slices: {
    *           - template: {
    *               fillOpacity: double,
    *               stroke: string HEX color,
    *               strokeWidth: int,
    *               strokeOpacity: double,
    *               tooltipText: string
    *           }
    *       }
    *   }
    *   - defaultSettings {
    *       - scale: double
    *       - shiftRadius: double
    *       - fillOpacity: double
    *   }
    *   - onHoverSettings {
    *       - scale: double
    *       - shiftRadius: double
    *       - fillOpacity: double
    *   }
    *   - onActiveSettings {
    *       - scale: double,
    *       - shiftRadius: double,
    *       - fillOpacity: double
    *   }
    *   - legend {
    *       - active: bool,
    *       - valueLabels: {
    *           - template {
    *               - text: string
    *           }
    *       }
    *   }
    */
    createPieChart = (chartId, config) => {
        // instantiate
        var chart;
        if(config.is3D) {
            chart = am4core.create(chartId, am4charts.PieChart3D);
        } else {
            chart = am4core.create(chartId, am4charts.PieChart);
        }


        // configure data
        if(!config.dataSource) {
            chart.data = config.data;
            pieSeries.dataFields.value = "value";
            pieSeries.dataFields.category = "category";
        } else {
            chart.dataSource.url = config.dataSource
        }

        // pie chart innerRadius
        if(config.innerRadius) {
            chart.innerRadius = am4core.percent(config.innerRadius);
        }
        
        // configure pieSeries
        var pieSeries;
        if(config.is3D) {
            pieSeries = chart.series.push(new am4charts.PieSeries3D());
        } else {
            pieSeries = chart.series.push(new am4charts.PieSeries());
        }
         

        if(config.pieSeries) {
            // configure dataFields
            if(config.pieSeries.dataFields) {
                pieSeries.dataFields.value = 'value';
                pieSeries.dataFields.category = 'category';

                if(config.data[0].color) {
                    // convert colors to amChart colors
                    for (let i = 0; i < config.data.length; i++) {
                        if(!config.data[i].color) {
                            showError('You need to specify color for every item in config > data. Problem on item index: ' + i);
                            return;
                        }

                        pieSeries.dataFields[i].color = am4core.color(pieSeries.dataFields[i].color);
                    }

                    // set color as propertyFields
                    pieSeries.slices.template.propertyFields.fill = 'color';
                }
            }

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


}

function showError(msg) {
    console.error('[flutter_web_amcharts] ' + msg);
}