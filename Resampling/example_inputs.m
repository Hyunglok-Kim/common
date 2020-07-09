% frame lat/lon
spatial_resol_main=0.15;
lat_up_main=35; lat_down_main=10; lon_left_main=0; lon_right_main=15;
lat_main_1d=[lat_up_main-spatial_resol_main/2:-spatial_resol_main:lat_down_main+spatial_resol_main/2];
lon_main_1d=[lon_left_main+spatial_resol_main/2:spatial_resol_main:lon_right_main-spatial_resol_main/2];
[lon_main, lat_main]=meshgrid(lon_main_1d, lat_main_1d);
% satelltie's lat/lon/variable
spatial_resol_input=0.15;
lat_up_input=30; lat_down_input=15; lon_left_input=10; lon_right_input=13;
lat_input_1d=[lat_up_input-spatial_resol_input/2:-spatial_resol_input:lat_down_input+spatial_resol_input/2];
lon_input_1d=[lon_left_input+spatial_resol_input/2:spatial_resol_input:lon_right_input-spatial_resol_input/2];
[lon_input, lat_input]=meshgrid(lon_input_1d, lat_input_1d);
lat_input=lat_input+rand(size(lat_input))*0.01;
lon_input=lon_input+rand(size(lon_input))*0.01;
VAR=rand([size(lat_input),3]);

VAR_r=[];
for i = 1:size(VAR,3) % parallel can be implemented
    VAR_r(:,:,i)=Resampling_C(lat_main, lon_main, lat_input, lon_input, VAR(:,:,i), 'nearest');
end
subplot(1,2,1)
mapshow(lon_input, lat_input, VAR)
subplot(1,2,2)
mapshow(lon_main, lat_main, VAR_r)