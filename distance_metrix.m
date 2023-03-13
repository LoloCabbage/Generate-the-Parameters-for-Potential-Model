function Grid_distance = distance_metrix(lat,lon)
global GridNum
Grid_distance = zeros(GridNum,GridNum);
    for i = 1:GridNum
        for j = 1:GridNum
            Grid_distance(i,j) = distance(lat(i),lon(i),lat(j),lon(j))/180*pi*6371;
%             e = referenceEllipsoid('WGS84','km');
%             Grid_distance(i,j) = distance(lat(i),lon(i),lat(j),lon(j),e,'degrees');
        end
    end
end

