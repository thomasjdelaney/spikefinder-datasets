# example julia script for loading spikefinder data
#
# for more info see https://github.com/codeneuro/spikefinder
#
# requires DataFrames, PyPlot
#

using DataFrames
using Gadfly

proj_dir = "/home/thomas/Spike_finder/"
train_dir = proj_dir * "train/"
dataset = "1"
calcium_train = readtable(train_dir * dataset * ".train.calcium.csv")
spikes_train = readtable(train_dir * dataset * ".train.spikes.csv")

function calciumSpikePlot(calcium, spikes, panel)
  x = range(0, 100/length(calcium), length(calcium))
  return plot(layer(x=x, y=calcium, Geom.line, Theme(default_color=colorant"grey")),
    layer(x=x, y=spikes/2-1, Geom.line, Theme(default_color=colorant"black")),
    Coord.cartesian(aspect_ratio=5.0),
    Scale.x_continuous(minvalue = 0, maxvalue = 100),
    Scale.y_continuous(minvalue = -2, maxvalue = 4),)
end

fluoro_spike_plot = calciumSpikePlot(calcium_train[:x0], spikes_train[:x0], [0, 100])
draw(PNG("fluoro_spike_plot.png", 300cm, 60cm), fluoro_spike_plot)
