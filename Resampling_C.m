function VAR1_r=Resampling_C(lat_main, lon_main, lat_input, lon_input, VAR, method)
%--------------------------BEGIN NOTE------------------------------%
% University of Virginia
%--------------------------END NOTE--------------------------------%
% ARGUMENTS:
% lat_main / lon_main : Target frame lat/lon data (m x n arrays)
% lat_input / lon_input : Satellite lat/lon data (m' x n' arrays)
% (NOTE: lat(i,1)>lat(i+1,1) (1<=i<=(size(lat_main,1)-1))
%        lon(1,i)<lon(1,i+1) (1<=i<=(size(lon_main,2)-1)) )
%
% VAR : Satellite's variable (m' x n' array)
% method: Method for resampling: (e.g., 'nearest')
%
% DESCRIPTION:
% This code resampled earth coordinates of the specified domain for 
% any "main" projection
%
% REVISION HISTORY: 
% 2 Jul 2020 Hyunglok Kim; initial specification
%-----------------------------------------------------------------%

if ~any(~(size(lat_main)==size(lat_input)))
    
    if sum(lat_main(:)~=lat_input(:))==0 && sum(lon_main(:)~=lon_input(:))==0
        disp('Resampling is not required.')
        VAR1_r=VAR;
    else
        nan_frame=nan(size(lat_main,1), size(lat_main,2));
        VAR1_r=nan_frame;
        
        valid_data=(~isnan((VAR)) & lat_input<=max(lat_main(:,1)) & lat_input>min(lat_main(:,1)) & lon_input<max(lon_main(1,:)) & lon_input>=min(lon_main(1,:)));
        valid_value=VAR(valid_data);
        t_lat=lat_input(valid_data);
        t_lon=lon_input(valid_data);
        
        t_lat_index=interp1(lat_main(:,1), 1:size(lat_main,1), t_lat,method);
        t_lon_index=interp1(lon_main(1,:), 1:size(lon_main,2), t_lon,method);
        index_array=sub2ind(size(lat_main), t_lat_index, t_lon_index);
        
        nan_valid=isnan(sum([t_lat_index, t_lon_index],2));
        valid_value(nan_valid)=[]; %t_lat_index(nan_valid)=[];t_lon_index(nan_valid)=[];
                
        [C,~,idx]=unique(index_array, 'stable');
        val = accumarray(idx,valid_value,[],@mean);   
        VAR1_r(C)=val;
    end
else
    
    nan_frame=nan(size(lat_main,1), size(lat_main,2));
    VAR1_r=nan_frame;
    
    valid_data=(~isnan((VAR)) & lat_input<=max(lat_main(:,1)) & lat_input>min(lat_main(:,1)) & lon_input<max(lon_main(1,:)) & lon_input>=min(lon_main(1,:)));
    valid_value=VAR(valid_data);
    t_lat=lat_input(valid_data);
    t_lon=lon_input(valid_data);
    
    t_lat_index=interp1(lat_main(:,1), 1:size(lat_main,1), t_lat,method);
    t_lon_index=interp1(lon_main(1,:), 1:size(lon_main,2), t_lon,method);
    index_array=sub2ind(size(lat_main), t_lat_index, t_lon_index);
    
    nan_valid=isnan(sum([t_lat_index, t_lon_index],2));
    valid_value(nan_valid)=[]; %t_lat_index(nan_valid)=[]; %t_lon_index(nan_valid)=[];
    
    [C,~,idx]=unique(index_array, 'stable');
    val = accumarray(idx,valid_value,[],@mean);    
    VAR1_r(C)=val;
end

