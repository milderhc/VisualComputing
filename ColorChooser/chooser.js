var width = 400;
var height = 400;
var pickerSize = 100;
var bottomSlider, leftSlider, hueSlider;

function setup ( ) {
    createCanvas(width, height);
    noStroke();

    hueSlider = createSlider(0, 360, 0);
    hueSlider.position(20, pickerSize + 30);
    saturationSlider = createSlider(0, 100, 0);
    saturationSlider.position(20, pickerSize + 60);
    brightnessSlider = createSlider(0, 100, 255);
    brightnessSlider.position(20, pickerSize + 90);
}


function draw ( ) {
    var h = hueSlider.value();
    var s = saturationSlider.value();
    var b = saturationSlider.value();
    text("Hue", 165, pickerSize + 35);
    text("Saturation", 165, pickerSize + 65);
    text("Brightness", 165, pickerSize + 95);

    noStroke();
    colorMode(HSB, pickerSize);
    for (i = 0; i < pickerSize; i++) {
        for (j = 0; j < pickerSize; j++) {
            stroke(i, j, b);
            point(i, j);
        }
    }
}
