@echo off

@echo Deleting old STL files.
del *.stl

@echo ------------------------------------------------------------------------------
@echo CurrentMonitor
@echo -----------------------
"C:\Program Files\OpenSCAD\openscad.com" -o CurrentMonitor.stl -D "buildBase=true;buildPushDown=true" CurrentMonitor.scad
"C:\Program Files\OpenSCAD\openscad.com" -o CurrentMonitor-Base.stl -D "buildBase=true;buildPushDown=false" CurrentMonitor.scad
"C:\Program Files\OpenSCAD\openscad.com" -o CurrentMonitor-PushDown.stl -D "buildBase=false;buildPushDown=true" CurrentMonitor.scad

@echo ------------------------------------------------------------------------------
@echo Building Environment V2 (Works for V3 and V4)
@echo -----------------------
"C:\Program Files\OpenSCAD\openscad.com" -o EnvironmentV2.stl -D "buildBase=true;buildPushDown=true" EnvironmentV2.scad
"C:\Program Files\OpenSCAD\openscad.com" -o EnvironmentV2-Base.stl -D "buildBase=true;buildPushDown=false" EnvironmentV2.scad
"C:\Program Files\OpenSCAD\openscad.com" -o EnvironmentV2-PushDown.stl -D "buildBase=false;buildPushDown=true" EnvironmentV2.scad

@echo ------------------------------------------------------------------------------
@echo Building Quad N-Fets
@echo -----------------------
"C:\Program Files\OpenSCAD\openscad.com" -o Quad-N-Fets.stl -D "buildBase=true;buildPushDown=true" Quad-N-Fets.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Quad-N-Fets-Base.stl -D "buildBase=true;buildPushDown=false" Quad-N-Fets.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Quad-N-Fets-PushDown.stl -D "buildBase=false;buildPushDown=true" Quad-N-Fets.scad

@echo ------------------------------------------------------------------------------
@echo Building Thermocouple
@echo -----------------------
"C:\Program Files\OpenSCAD\openscad.com" -o Thermocouple.stl -D "buildBase=true;buildPushDown=true" Thermocouple.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Thermocouple-Base.stl -D "buildBase=true;buildPushDown=false" Thermocouple.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Thermocouple-PushDown.stl -D "buildBase=false;buildPushDown=true" Thermocouple.scad

@echo ------------------------------------------------------------------------------
@echo BigLatchingRelay
@echo -----------------------
"C:\Program Files\OpenSCAD\openscad.com" -o BigLatchingRelay.stl -D "buildBase=true;buildPushDown=true" BigLatchingRelay.scad
"C:\Program Files\OpenSCAD\openscad.com" -o BigLatchingRelay-Base.stl -D "buildBase=true;buildPushDown=false" BigLatchingRelay.scad
"C:\Program Files\OpenSCAD\openscad.com" -o BigLatchingRelay-PushDown.stl -D "buildBase=false;buildPushDown=true" BigLatchingRelay.scad

@echo ------------------------------------------------------------------------------
@echo Building Quad P-Fets
@echo -----------------------
"C:\Program Files\OpenSCAD\openscad.com" -o Quad-P-Fets.stl -D "buildBase=true;buildPushDown=true" Quad-P-Fets.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Quad-P-Fets-Base.stl -D "buildBase=true;buildPushDown=false" Quad-P-Fets.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Quad-P-Fets-PushDown.stl -D "buildBase=false;buildPushDown=true" Quad-P-Fets.scad


@echo ===============================================================================